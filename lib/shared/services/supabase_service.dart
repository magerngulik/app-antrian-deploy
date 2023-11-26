// total user

import 'package:antrian_app/main.dart';

class SupabaseSevice {
  Future<Map> getTotalUser() async {
    final response = await supabase.rpc('get_roles_summary');
    return response;
  }

  Future getMedia() async {
    try {
      final response = await supabase
          .from('configuration')
          .select('*')
          .eq('type_configuration', 'image')
          .order('updated_at', ascending: false)
          .limit(1)
          .single();

      return response;
    } catch (e) {
      return null;
    }
  }
}
