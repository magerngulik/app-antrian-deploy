// total user

import 'package:antrian_app/main.dart';

class SupabaseSevice {
  Future<Map> getTotalUser() async {
    final response = await supabase.rpc('get_roles_summary');
    return response;
  }
}
