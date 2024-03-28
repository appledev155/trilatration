import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trilateration/config/constants.dart';

// http://192.168.1.100:5000/api/v1/get-device-data
class Repository {
  final _host = "192.168.1.100:5000";
  final _contextRoot = Constants.root;
  Map<String, String> get _headers => {'Accept': 'application/json'};

Uri getURL(String contextPath) {
    Uri uri;
    if (Constants.protocol == "HTTPS") {
      uri = Uri.https(_host, '$contextPath');
    } else {
      uri = Uri.http(_host, '$contextPath');
    }
    return uri;
  }

  Future<dynamic> requestGET({required String? path}) async {
    var _headersData = _headers;
    final uri = getURL('$_contextRoot$path');
    try {
      final results = await http.get(uri, headers: _headersData);
      print("result is ------------${results.body}");
      if (results.body.isNotEmpty) {
        final jsonObject = json.decode(results.body);
        return jsonObject;
      } else {
        return {};
      }
    } catch (e, _) {
      print('GET Api Error  $e - $path');
      print(_);
    }
  }

  Future<dynamic> requestPOST({required String? path}) async {
    var _headersData = _headers;
    final uri = getURL('$_contextRoot $path');
    try {
      final results = await http
          .post(uri, headers: _headersData)
          .timeout(const Duration(seconds: 100));
      if (results.body.isEmpty) {
        final jsonObject = json.decode(results.body);
        return jsonObject;
      } else {
        return {};
      }
    } catch (e) {
      print('POST Api Error  $e - $path');
    }
    return {};
  }

  Future<dynamic> requestDELETE({required String? path}) async {
    var _headersData = _headers;
    final uri = getURL('$path');
    try {
      final results = await http
          .delete(uri, headers: _headersData)
          .timeout(const Duration(seconds: 10));
      if (results.body.isEmpty) {
        final jsonObject = json.decode(results.body);
        return jsonObject;
      } else {
        return {};
      }
    } catch (e) {
      print('POST Api Error  $e - $path');
    }
  }
}
