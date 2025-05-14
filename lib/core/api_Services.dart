import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static Future<dynamic> get(String url, {int sec = 30}) async {
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              // Update token if needed
              'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            },
          )
          .timeout(Duration(seconds: sec));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Server responded with status: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Timeout');
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
  
}