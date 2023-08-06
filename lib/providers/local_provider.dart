import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider {
  Future<void> saveApiData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_data', data);
    print(data);
  }

  Future<String?> getApiData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_data');
  }
}
