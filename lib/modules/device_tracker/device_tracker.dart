
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:trilateration/modules/device_tracker/model/device_tracker_model.dart';

class DeviceTracker extends StatefulWidget {
  const DeviceTracker({super.key});

  @override
  State<DeviceTracker> createState() => _DeviceTrackerState();
}

class _DeviceTrackerState extends State<DeviceTracker> {
  List<DeviceTrackerModel>? devicetrackermodelList = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.100:5000/api/v1/map-data'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        devicetrackermodelList =
            jsonData.map((item) => DeviceTrackerModel.fromJson(item)).toList();
      });
      print("============================$jsonData");
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          title: const Text("Device Tracker List"),
        ),
        body: devicetrackermodelList == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                                label: Text(
                              "Device Tracker",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text("Duration",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text("X-Coordinate",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text("Y-Coordinate",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ],
                          rows: devicetrackermodelList!
                              .map((item) => DataRow(cells: <DataCell>[
                                    DataCell(Text(item.devicetrack.toString())),
                                    DataCell(Text(item.duration.toString())),
                                    DataCell(Text(item.xcoordinate.toString())),
                                    DataCell(Text(item.ycoordinate.toString())),
                                  ]))
                              .toList()),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => DeviceChart(
                          //               devicetrackermodelList: devicetrackermodelList!,
                          //             )));
                        },
                        child: const Text("Show Graph"))
                  ],
                ),
              ));
  }
}
