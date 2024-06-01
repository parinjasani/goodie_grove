import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static const String KEY_IS_LOGIN = "isLogin";
  static const String KEY_IS_ONBOARDING = "visited";
  static late SharedPreferences _instance;

  static Future<SharedPreferences> init() async {
    _instance = await SharedPreferences.getInstance();
    return _instance;
  }


  static Future<bool> updateloginstatus(bool status) async {

    return await _instance.setBool(KEY_IS_LOGIN,status);

  }

  static Future<bool> getloginstatus(bool status) async{
    return await _instance.getBool(KEY_IS_LOGIN) ?? false;
  }


}
