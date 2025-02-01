import 'dart:convert';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:get/get.dart' as getx;
import 'package:location_tracker/constants/endpoints.dart';
import 'package:location_tracker/utils/exception.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RequestType { get, post, put, delete }

enum LoggerType { d, e, i, f, t, w }

class Helpers {
  static http.Client? _client;
  static SharedPreferences? _prefs;

  static setHelpers({required SharedPreferences prefs}) {
    _prefs = prefs;
    _client = http.Client();
  }

  // static String? getUserToken() {
  //   return _prefs!.getString(AppKeys.authToken);
  // }

  // static Future<bool> setUserToken(String token) async {
  //   bool check = await _prefs!.setString(
  //     AppKeys.authToken,
  //     token,
  //   );
  //   if (check) {
  //     getx.Get.find<GlobalController>().isLoggedIn.value =
  //         Helpers.getUserToken() != null;
  //   }
  //   return check;
  // }

  // static Future<bool> setOnboardedUser(bool value) async {
  //   return await _prefs!.setBool(AppKeys.onboardedUser, value);
  // }

  // static String? getUserInformation() {
  //   return _prefs!.getString(AppKeys.userDetails);
  // }

  // static bool? onboardedUser() {
  //   return _prefs!.getBool(AppKeys.onboardedUser);
  // }

  // static Future<bool> setUserInformation(UserModel model) async {
  //   return await _prefs!.setString(
  //     AppKeys.userDetails,
  //     model.toJson(),
  //   );
  // }

  // static void clearUserToken() {
  //   _prefs!.remove(AppKeys.authToken);
  //   _prefs!.remove(AppKeys.userDetails);
  //   _prefs!.clear();
  // }

  static void logger({
    required LoggerType type,
    required String message,
    StackTrace? stack,
  }) {
    final logger = Logger(printer: PrettyPrinter());

    switch (type) {
      case LoggerType.d:
        logger.d(message, stackTrace: stack);
        break;
      case LoggerType.e:
        logger.e(message, stackTrace: stack);
        break;
      case LoggerType.i:
        logger.i(message, stackTrace: stack);
        break;
      case LoggerType.f:
        logger.f(message, stackTrace: stack);
        break;
      case LoggerType.t:
        logger.t(message, stackTrace: stack);
        break;
      case LoggerType.w:
        logger.w(message, stackTrace: stack);
        break;
    }
  }

  static Future<List<dynamic>?> sendRequest(
    RequestType type,
    String path, {
    Map<String, dynamic>? queryParams,
    bool encoded = false,
    dynamic data,
    dynamic listData,
    Map<String, String>? files,
  }) async {
    try {
      final uri = Uri.parse('${EndPoints.baseURL}$path')
          .replace(queryParameters: queryParams);

      http.Response response;
      Map<String, String> headers = {
        'Content-Type':
            encoded ? 'application/x-www-form-urlencoded' : 'application/json',
      };

      switch (type) {
        case RequestType.get:
          response = await _client!.get(uri, headers: headers);
          break;

        case RequestType.post:
          var body;
          if (data != null) {
            body = jsonEncode(data);
          } else if (listData != null) {
            body = jsonEncode(listData);
          }

          if (files != null) {
            // Handle multipart request
            var request = http.MultipartRequest('POST', uri);
            request.headers.addAll(headers);

            // Add fields
            if (data != null) {
              data.forEach((key, value) {
                request.fields[key] = value.toString();
              });
            }

            // Add files
            for (var entry in files.entries) {
              request.files.add(
                  await http.MultipartFile.fromPath(entry.key, entry.value));
            }

            var streamedResponse = await request.send();
            response = await http.Response.fromStream(streamedResponse);
          } else {
            response = await _client!.post(
              uri,
              headers: headers,
              body: body,
            );
          }
          break;

        case RequestType.put:
          response = await _client!.put(
            uri,
            headers: headers,
            body: jsonEncode(data),
          );
          break;

        case RequestType.delete:
          response = await _client!.delete(uri, headers: headers);
          break;
      }

      if (response.statusCode == 200 || response.statusCode == 202) {
        return jsonDecode(response.body) as List<dynamic>;
      } else if (response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 402) {
        throw ServerException(
          code: response.statusCode,
          message: jsonDecode(response.body)['message'],
        );
      } else {
        throw ServerException(
          code: response.statusCode,
          message: jsonDecode(response.body)['message'],
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message, code: e.code);
    } on io.SocketException {
      throw ServerException(message: "No Internet", code: 0);
    } catch (e) {
      print(e.toString());
      throw ServerException(
        message: e.toString(),
        code: 500,
      );
    }
  }
}
