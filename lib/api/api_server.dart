import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trilateration/modules/zone/model/room_model.dart';
import 'package:trilateration/modules/zone/model/zone_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.100:5000";

  static Future<dynamic> fetchDeviceList() async {
    final response = await http.get(Uri.parse('$baseUrl/api/v1/devices'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print("================================$data");
      return data;
    } else {
      throw Exception('Failed to load device list');
    }
  }

    Future<List<Zone>> fetchZones() async {
    final response = await http.get(Uri.parse('/api/v1/get-zone'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return List<Zone>.from(jsonData.map((data) => Zone.fromJson(data)));
    } else {
      throw Exception('Failed to load zones');
    }
  }

   Future<List<Room>> fetchRooms() async {
    final response = await http.get(Uri.parse('YOUR_ROOM_API_URL_HERE'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return List<Room>.from(jsonData.map((data) => Room.fromJson(data)));
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  

}



