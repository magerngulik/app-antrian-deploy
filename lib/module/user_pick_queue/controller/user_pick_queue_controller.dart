import 'package:antrian_app/core.dart';
import 'package:antrian_app/main.dart';
import 'package:antrian_app/module/user_pick_queue/data/user_pick_queue_services.dart';
import 'package:antrian_app/shared/services/m_dialog.dart';
import 'package:antrian_app/shared/util/q_save_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/user_pick_queue_view.dart';

class UserPickQueueController extends GetxController {
  UserPickQueueView? view;
  //user
  Map<String, dynamic> userData = {};
  String? idUser;
  String token = "";
  String name = "";
  String email = "";
  int assignmentId = 0;
  int roleUserId = 0;
  String layanan = "";
  String unit = "";
  String currentQueue = "-";
  int waitingQueue = 0;
  //services
  UserPickQueueServices services = UserPickQueueServices();
  //error
  String errorMessage = "";
  //success
  Map<String, dynamic> dataRole = {};
  var log = Logger();

  //variable data untuk select ke queue tabel
  var codeId = 0; // untuk get code_id
  var codeQueueId = 0; //untuk get code_queue_id

  @override
  void onInit() {
    super.onInit();
    getUser();
    getCurrentQueue();
    getCountQueue();
  }

  Future<bool?> isProcess() async {
    String kondisiProcess = 'process';
    try {
      final data = await supabase
          .from('queues')
          .select('*')
          .eq('status', kondisiProcess)
          .eq('assignments_id', assignmentId)
          .limit(1)
          .order('created_at', ascending: true);
      if (data.isEmpty) {
        Ql.logWarning(data);
        return true;
      } else {
        // Ql.logWarning("Kondisi ke dua");
        Ql.logD(data);
        Get.dialog(MDialogError(
            onTap: () {
              Get.back();
            },
            message: "Selekai Terlebih dahulu proses yang sedang berlangsung"));
        return false;
      }
    } catch (e) {
      Ql.logError("error to pass condisiton first", e);
      return null;
    }
  }

  pickQueue() async {
    // Ql.logInfo(assignmentId);
    bool onProsess = await isProcess() ?? false;

    if (onProsess == false) {
      return;
    }

    String pickQueueCoondisition = 'waiting';
    try {
      final data = await supabase
          .from('queues')
          .select('*')
          .eq('code_id', codeQueueId)
          .eq('status', pickQueueCoondisition)
          .limit(1)
          .order('created_at', ascending: true);
      // Ql.logWarning(data);

      if (data.isEmpty) {
        Ql.logD("kondisi berjalan");
        Get.dialog(MDialogError(
            onTap: () {
              Get.back();
              getCurrentQueue();
              getCountQueue();
            },
            message: "Belum ada antrian yang tersedia"));

        return;
      } else {
        Ql.logWarning(data[0]);
        var sourceQueue = data[0];
        var idQueueData = sourceQueue['id'];
        try {
          Map dataChange = {
            "assignments_id": assignmentId,
            "status": "process"
          };

          await supabase
              .from('queues')
              .update(dataChange)
              .match({'id': idQueueData});
          Get.dialog(MDialogSuccess(
              onTap: () {
                Get.back();
              },
              message: "Berhasil Call Antrian"));
        } catch (e) {
          Ql.logError("error ketika ingin mengupdate queue", e);
        }
      }
    } catch (e) {
      Ql.logError('error ketika get ready assignment', e);
    }
    getCurrentQueue();
    getCountQueue();
  }

  getCurrentQueue() async {
    await Future.delayed(const Duration(seconds: 1));
    Ql.logError("data assignmen", assignmentId);
    try {
      final dataCurentAssignment = await supabase
          .from('queues')
          .select('*')
          .eq('status', 'process')
          .eq('assignments_id', assignmentId)
          .limit(1);

      Ql.logWarning("$dataCurentAssignment $assignmentId");
      if (dataCurentAssignment.isEmpty) {
        Ql.logD("data is empty bro");
        currentQueue = "-";
      } else {
        Ql.logD(dataCurentAssignment);
        currentQueue = dataCurentAssignment[0]['kode'];
      }
    } catch (e) {
      Ql.logError("error ketika get current queue", e);
    }
    update();
  }

  //untuk mendapatkan antrian di belakang
  void getCountQueue() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final data = await supabase
          .from('queues')
          .select('*')
          .eq('status', 'waiting')
          .eq('code_id', codeId);
      Ql.logF(data);
      // Ql.logF("panjang data ${data.length}");
      if (data.isEmpty) {
        waitingQueue = 0;
      } else {
        waitingQueue = data.length;
      }
      update();
    } catch (e) {
      Ql.logError("error ketika ingin mendapatkan jumlaho data", e);
    }
  }

//get user yang sedang login
  getUser() async {
    if (supabase.auth.currentUser == null) {
      Get.off(const LoginView());
    } else {
      idUser = supabase.auth.currentUser!.id;
      assignmentId = await SharedPreferencesHelper.getSingleDataInt(
              key: "assignment_id") ??
          0;

      roleUserId =
          await SharedPreferencesHelper.getSingleDataInt(key: "role_user_id") ??
              0;

      if (assignmentId == 0 || roleUserId == 0) {
        log.w("assingment id atau role userid tidak di temukan");
        Get.off(const LoginView());
      }
      log.f({
        "assingment id": assignmentId,
        "role user id ": roleUserId,
        "user id": supabase.auth.currentUser!.id
      });
    }
    //code untuk role user
    try {
      final dataRoleUser = await supabase
          .from('role_users')
          .select('*')
          .eq('id', roleUserId)
          .limit(1);
      codeId = dataRoleUser[0]['code_id'];
      Ql.logD(codeId);
    } catch (e) {
      Ql.logError("error ketika get role user", "$e");
    }

    try {
      final dataCodeQueue = await supabase
          .from('code_queues')
          .select('*')
          .eq('id', codeId)
          .limit(1);

      codeQueueId = dataCodeQueue[0]['id'];
      Ql.logWarning(codeQueueId);
    } catch (e) {
      Ql.logError("error ketika get queue user", "$e");
    }
  }

  //menyudahi sessi pelayanan, merubah status dari queue costumer menjadi complete
  confirmQueue() async {
    debugPrint("confirm colect");
    var confirmCondition = "process";
    // var confirmCondition = "complete";
    try {
      final data = await supabase
          .from('queues')
          .select('*')
          .eq('assignments_id', assignmentId)
          .eq('status', confirmCondition)
          .limit(1)
          .order('created_at', ascending: true);

      if (data.isEmpty) {
        Get.dialog(MDialogError(
            onTap: () {
              Get.back();
            },
            message: "TIdak ada data yang di layani"));
      } else {
        // Ql.logWarning(data);
        Ql.logInfo("status jalan");
        var currentData = data[0];
        Ql.logWarning(currentData);
        var confirmCurrentId = currentData['id'];

        try {
          Map dataChange = {"status": 'complete'};

          await supabase
              .from('queues')
              .update(dataChange)
              .match({'id': confirmCurrentId});

          Get.dialog(MDialogSuccess(
              onTap: () {
                Get.back();
                getCurrentQueue();
                getCountQueue();
              },
              message: "Berhasil untuk menyelesaikan transaksi"));
        } catch (e) {
          Get.dialog(MDialogError(
              onTap: () {
                getCurrentQueue();
                getCountQueue();
              },
              message:
                  "Terjadi kesalahan ketika inggin update data di confirm : $e"));
        }
      }
    } catch (e) {
      Get.dialog(MDialogError(
          onTap: () {
            getCurrentQueue();
            getCountQueue();
          },
          message: "Terjadi error ketika mendapatkan current data : $e"));
      return;
    }
  }

  //menyudahi sessi pelayanan, merubah status dari queue costumer menjadi complete
  skipQueue() async {
    debugPrint("confirm colect");
    var confirmCondition = "process";
    // var confirmCondition = "complete";
    try {
      final data = await supabase
          .from('queues')
          .select('*')
          .eq('assignments_id', assignmentId)
          .eq('status', confirmCondition)
          .limit(1)
          .order('created_at', ascending: true);

      if (data.isEmpty) {
        Get.dialog(MDialogError(
            onTap: () {
              Get.back();
            },
            message: "TIdak ada data yang di layani"));
      } else {
        // Ql.logWarning(data);
        Ql.logInfo("status jalan");
        var currentData = data[0];
        Ql.logWarning(currentData);
        var confirmCurrentId = currentData['id'];

        try {
          Map dataChange = {"status": 'skip'};

          await supabase
              .from('queues')
              .update(dataChange)
              .match({'id': confirmCurrentId});

          Get.dialog(MDialogSuccess(
              onTap: () {
                Get.back();
                getCurrentQueue();
                getCountQueue();
              },
              message: "Berhasil untuk skip transaksi"));
        } catch (e) {
          Get.dialog(MDialogError(
              onTap: () {
                getCurrentQueue();
                getCountQueue();
              },
              message:
                  "Terjadi kesalahan ketika inggin update data di skip : $e"));
        }
      }
    } catch (e) {
      Get.dialog(MDialogError(
          onTap: () {
            getCurrentQueue();
            getCountQueue();
          },
          message: "Terjadi error ketika mendapatkan current data : $e"));
      return;
    }
  }

  recallQueue() async {
    debugPrint("confirm colect");
    var confirmCondition = "process";
    // var confirmCondition = "complete";
    try {
      final data = await supabase
          .from('queues')
          .select('*')
          .eq('assignments_id', assignmentId)
          .eq('status', confirmCondition)
          .limit(1)
          .order('created_at', ascending: true);

      if (data.isEmpty) {
        Get.dialog(MDialogError(
            onTap: () {
              Get.back();
            },
            message: "TIdak ada data yang di layani"));
      } else {
        // Ql.logWarning(data);
        Ql.logInfo("status jalan");
        var currentData = data[0];
        Ql.logWarning(currentData);
        var confirmCurrentId = currentData['id'];

        final currentTimestamp = DateTime.now();
        final formattedTimestamp = currentTimestamp.toIso8601String();

        try {
          Map dataChange = {"updated_at": formattedTimestamp};

          await supabase
              .from('queues')
              .update(dataChange)
              .match({'id': confirmCurrentId});

          Get.dialog(MDialogSuccess(
              onTap: () {
                Get.back();
                getCurrentQueue();
                getCountQueue();
              },
              message: "Berhasil untuk recall transaksi"));
        } catch (e) {
          Get.dialog(MDialogError(
              onTap: () {
                Get.back();
                getCurrentQueue();
                getCountQueue();
                Ql.logError("error ketika recall", e);
              },
              message:
                  "Terjadi kesalahan ketika inggin update data di recall : $e"));
        }
      }
    } catch (e) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
            getCurrentQueue();
            getCountQueue();
          },
          message: "Terjadi error ketika mendapatkan current data : $e"));
      return;
    }
  }

  doLogout() async {
    try {
      await supabase.auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      Get.dialog(const AlertDialogNotif(
          title: "Anda gagal logout",
          srcImages: "assets/images/notif_failed.png"));
    }
  }

  // var data = await services.skipQueue(assignmentId);
  // debugPrint("assignment id = $assignmentId");
  // data.fold((l) {
  //   Get.dialog(MDialogError(
  //       onTap: () {
  //         Get.back();
  //       },
  //       message: l));
  // }, (r) {
  //   var message = r['message'];
  //   Get.dialog(MDialogSuccess(
  //       onTap: () {
  //         getCurrentQueue();
  //         Get.back();
  //       },
  //       message: message));
  //   getCurrentQueue();
  // });

  // var data = await services.viewQueue(assignmentId);
  // data.fold((l) {
  //   Get.dialog(MDialogError(
  //       onTap: () {
  //         Get.back();
  //       },
  //       message: "error : $l"));
  //   update();
  // }, (r) {
  //   var source = r['data'];
  //   var queue = source['queue'];
  //   var waitingCount = source['last_queue'];
  //   debugPrint("queue: $queue");
  //   debugPrint("waiting queue = $waitingCount");
  //   if (queue == null) {
  //     currentQueue = "-";
  //   } else {
  //     var waitingCode = queue['kode'];
  //     currentQueue = waitingCode;
  //   }
  //   waitingQueue = waitingCount;
  //   update();
  // });
  // var data = await services.confirmQueue(assignmentId);
  // debugPrint("assignment id = $assignmentId");
  // data.fold((l) {
  //   Get.dialog(MDialogError(
  //       onTap: () {
  //         Get.back();
  //       },
  //       message: l));
  // }, (r) {
  //   var message = r['message'];
  //   Get.dialog(MDialogSuccess(
  //       onTap: () {
  //         getCurrentQueue();
  //         Get.back();
  //       },
  //       message: message));
  //   getCurrentQueue();
  // });
  // var data = await services.recallQueue(assignmentId);
  // debugPrint("assignment id = $assignmentId");
  // data.fold((l) {
  //   Get.dialog(MDialogError(
  //       onTap: () {
  //         Get.back();
  //       },
  //       message: l));
  // }, (r) {
  //   var message = r['message'];
  //   Get.dialog(MDialogSuccess(
  //       onTap: () {
  //         getCurrentQueue();
  //         Get.back();
  //       },
  //       message: message));
  //   getCurrentQueue();
  // });
}
