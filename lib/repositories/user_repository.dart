import 'package:itsparktask/const/urls.dart';
import 'package:itsparktask/models/user.dart';
import 'package:itsparktask/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<User> login(String email, String password) async {
    print("hollpp");
    final response = await ApiService.post(
      endPoint: AppUrls.LOGIN_URL,
      body: {
        'email': email,
        'password': password,
      },
    );
    print("this is the $response");
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString('accesstoken', response['token']),
    ]);
    final userData = await ApiService.get(
      endPoint: AppUrls.LOADME_URL,
    );
    print("load me");
    return User.fromJson(userData["data"]);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await ApiService.post(
      endPoint: AppUrls.LOGOUT_URL,
    );
    await prefs.remove('token');
  }
}
