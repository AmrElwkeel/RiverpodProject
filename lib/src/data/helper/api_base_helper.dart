

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_project/src/constant/constant.dart';
import 'package:riverpod_project/src/data/data_source/shared_preferences/shared_preferences.dart';
import 'package:riverpod_project/src/data/helper/api_exceptions.dart';

class ApiBaseHelper implements ApiHelperInterface {
  final String? authToken = SharedPreferencesHelperImpl().getValue('authToken');

  @override
  Future<dynamic> request(String url, String method, dynamic body ) async {

    final response = await _sendRequest(Constant.apiURL + url, method, body);

    return _returnResponse(response);
  }

  Future<http.Response> _sendRequest(String url, String method, dynamic body) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (authToken != null && authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken'; // Add token to headers
    }

    if (method == 'POST') {
      final response = await http.post(Uri.parse(url), body: jsonEncode(body), headers: headers);

      return response;
    } else if (method == 'GET') {
      final response = await http.get(Uri.parse(url), headers: headers);

      return response;
    } else if (method == 'PUT') {
      final response = await http.put(Uri.parse(url), body: jsonEncode(body), headers: headers);
      return response;
    } else if (method == 'PATCH') {
      final response = await http.patch(Uri.parse(url), body: jsonEncode(body), headers: headers);
      return response;
    } else if (method == 'DELETE') {
      final response = await http.delete(Uri.parse(url), headers: headers);

      return response;
    }

    throw Exception('Unsupported HTTP method: $method');
  }

  dynamic _returnResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body;

    if (_isSuccess(statusCode)) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      return responseJson;
    } else {
      throw _getException(statusCode, responseBody);
    }
  }

  bool _isSuccess(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  Exception _getException(int statusCode, String responseBody) {
    switch (statusCode) {
      case 400:
        if (jsonDecode(responseBody).containsKey('non_field_errors')) {
          var badResponseResult = jsonDecode(responseBody)['non_field_errors'][0];

          return BadRequestException(badResponseResult);
        } else if (jsonDecode(responseBody).containsKey('phone')) {
          var badResponseResult = jsonDecode(responseBody)['phone'][0];

          return BadRequestException(badResponseResult);
        } else if (jsonDecode(responseBody).containsKey('password')) {
          var badResponseResult = jsonDecode(responseBody)['password'][0];

          return BadRequestException(badResponseResult);
        } else {
          var badResponseResult = jsonDecode(responseBody);
          //
          // return BadRequestException(responseBody);
          return BadRequestException(badResponseResult['message']);
        }

      case 401:
        return UnauthorizedException(responseBody);
      case 403:
        return ForbiddenException(responseBody);
      case 500:
        return ServerErrorException('Internal server error occurred. StatusCode: $statusCode');
      default:
        return FetchDataException(
            'Error occurred while communicating with the server. StatusCode: $statusCode');
    }
  }

}
abstract class ApiHelperInterface {
  Future<dynamic> request(String url, String method, dynamic body );
}
