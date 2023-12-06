class CodeQueue {
  final int id;
  final String name;
  final String queueCode;
  final String createdAt;
  final String updatedAt;

  CodeQueue({
    required this.id,
    required this.name,
    required this.queueCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CodeQueue.fromJson(Map<String, dynamic> json) {
    return CodeQueue(
      id: json['id'],
      name: json['name'],
      queueCode: json['queue_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class RoleUser {
  final int id;
  final String nameRole;
  final int codeId;
  final String createdAt;
  final String updatedAt;
  final CodeQueue codeQueues;

  RoleUser({
    required this.id,
    required this.nameRole,
    required this.codeId,
    required this.createdAt,
    required this.updatedAt,
    required this.codeQueues,
  });

  factory RoleUser.fromJson(Map<String, dynamic> json) {
    return RoleUser(
      id: json['id'],
      nameRole: json['name_role'],
      codeId: json['code_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      codeQueues: CodeQueue.fromJson(json['code_queues']),
    );
  }
}

class Assignment {
  final int id;
  final String userId;
  final int roleUsersId;
  final String createdAt;
  final String updatedAt;
  final RoleUser roleUsers;

  Assignment({
    required this.id,
    required this.userId,
    required this.roleUsersId,
    required this.createdAt,
    required this.updatedAt,
    required this.roleUsers,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      userId: json['user_id'],
      roleUsersId: json['role_users_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      roleUsers: RoleUser.fromJson(json['role_users']),
    );
  }
}

class DataModel {
  final int id;
  final String kode;
  final String status;
  final int assignmentsId;
  final String createdAt;
  final String updatedAt;
  final int codeId;
  final Assignment assignments;

  DataModel({
    required this.id,
    required this.kode,
    required this.status,
    required this.assignmentsId,
    required this.createdAt,
    required this.updatedAt,
    required this.codeId,
    required this.assignments,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      kode: json['kode'],
      status: json['status'],
      assignmentsId: json['assignments_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      codeId: json['code_id'],
      assignments: Assignment.fromJson(json['assignments']),
    );
  }
}
