import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:itsparktask/const/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

enum HttpMethod { get, post, put, delete, patch }

class ApiService {
  static dynamic _invoke(
      {required String endPoint,
      required HttpMethod method,
      Map<String, dynamic>? query,
      bool decode = true,
      Map<String, dynamic>? body}) async {
    Uri uri = Uri.parse("${AppUrls.BASE_URL}$endPoint")
        .replace(queryParameters: query);
    Map<String, String> header = <String, String>{};
    var pref = await SharedPreferences.getInstance();
    String? token = pref.getString("accesstoken");
    if (token != null) {
      header = {"Authorization": "Bearer $token"};
    }
    late http.Response response;
    switch (method) {
      case HttpMethod.get:
        response = await http.get(uri, headers: header);
        print('get ${response.statusCode}');
        break;
      case HttpMethod.post:
        header["Content-Type"] = "application/json; charset=UTF-8";
        response = await http.post(uri,
            headers: header, body: convert.jsonEncode(body));
        print('post ${response.statusCode}');
        break;
      case HttpMethod.put:
        header["Content-Type"] = "application/json; charset=UTF-8";
        response = await http.put(uri,
            headers: header, body: convert.jsonEncode(body));
        break;
      case HttpMethod.delete:
        response = await http.delete(uri,
            headers: header, body: convert.jsonEncode(body));
        break;
      case HttpMethod.patch:
        header["Content-Type"] = "application/json; charset=UTF-8";
        response = await http.patch(uri,
            headers: header, body: convert.jsonEncode(body));
        break;
    }
    if ([200, 201, 204].contains(response.statusCode)) {
      print("this is the ${response.body}");
      return convert.jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      //  Attempt to refresh the token
      // if (await _refreshToken()) {
      //   Retry the original request with the new token
      //   return _invoke(
      //       endPoint: endPoint,
      //       method: method,
      //       query: query,
      //       body: body,
      //       decode: decode);
      // } else {
      //   throw HttpException("Failed to refresh token");
      // }
    } else {
      throw HttpException(
          "Server respond with ${response.statusCode} http code and body = ${convert.jsonDecode(response.body)["message"]} ");
    }
  }

  static Future<dynamic> get({required endPoint, Map<String, dynamic>? query}) {
    return _invoke(endPoint: endPoint, method: HttpMethod.get, query: query);
  }

  static Future<dynamic> post(
      {required endPoint,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query,
      bool decode = true}) {
    return _invoke(
        endPoint: endPoint,
        method: HttpMethod.post,
        query: query,
        body: body,
        decode: decode);
  }

  static dynamic patch(
      {required endPoint,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) {
    return _invoke(
        endPoint: endPoint, method: HttpMethod.patch, query: query, body: body);
  }

  static dynamic put({required endPoint, Map<String, dynamic>? body}) {
    return _invoke(endPoint: endPoint, method: HttpMethod.put, body: body);
  }

  static dynamic delete(endPoint,
      {Map<String, dynamic>? query, Map<String, dynamic>? body}) {
    return _invoke(
        endPoint: endPoint,
        method: HttpMethod.delete,
        query: query,
        body: body);
  }
  // static Future<bool> _refreshToken() async {
  //   var pref = await SharedPreferences.getInstance();
  //   String? refreshToken = pref.getString("refreshtoken");
  //   if (refreshToken == null) {
  //     return false;
  //   }

  //   Uri uri = Uri.parse("${AppUrls.BASE_URL}${AppUrls.REFRESH_URL}");
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //     "Authorization": "Bearer $refreshToken"
  //   };

  //   var response = await http.post(uri,
  //       headers: headers,
  //       body: convert.jsonEncode({"refreshToken": refreshToken}));
  //   if (response.statusCode == 200) {
  //     var data = convert.jsonDecode(response.body)["data"];
  //     print(data);
  //     await pref.setString("accesstoken", data["accesstoken"]);
  //     await pref.setString("refreshtoken", data["refreshtoken"]);
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
