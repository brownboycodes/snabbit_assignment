

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{
  late SharedPreferencesAsync prefs;
 factory SharedPreferencesService() {
    _singleton.prefs = SharedPreferencesAsync();
    return _singleton;
  }

  SharedPreferencesService._internal();
 static final SharedPreferencesService _singleton = SharedPreferencesService._internal();


void savePath(String id) async{
  await prefs.setString('path',id);
}

Future<String> checkStorage() async{
  final path = await prefs.getString('path') ?? '';
  return path;
}

void deletePath() async{
  await prefs.remove("path");
}
}