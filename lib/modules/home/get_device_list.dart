import 'package:flutter/material.dart';
import 'package:trilateration/api/api.dart';
import 'package:trilateration/api/api_server.dart';
import 'package:trilateration/component/app_drawer.dart';
import 'package:trilateration/modules/Ble_Device/ble_device.dart';
import 'package:trilateration/modules/login/loginpage.dart';
import 'package:trilateration/modules/measured_Pow/measured_Power.dart';
import 'package:trilateration/modules/zone/pages/zone_page.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  List<dynamic> deviceList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: const Text('Device List'),
        ),
        drawer: _drawer(),
        body: ListView.builder(
          itemCount: deviceList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(deviceList[index]['device_mac_address']),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(deviceList[index]['device_type'],style: ,),

                  Text(
                      "x= ${deviceList[index]['x_coordinate'].toString()} , y= ${deviceList[index]['y_coordinate'].toString()}"),
                      
                ],
              ),
              onTap: () {
                if (deviceList[index]['device_type'] == 'Gateway') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MeasuredPowerd(deviceInfo: deviceList[index])));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ZonePage()));
                }
              },
            );
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.blue.shade800,
              heroTag: "Scan",
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              onPressed: () {
                _fetchDeviceList();
              },
              child: const Text(
                "Scan",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue.shade800,
              heroTag: "Add",
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BleDevice()));
              },
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ));
  }

  _fetchDeviceList() async {
    final ApiProvider apiProvider = ApiProvider();
    try {
      final List<dynamic> list = await ApiService.fetchDeviceList();
      //  final List<dynamic> list = await apiProvider.fetchData();
      print("******////************$list");
      setState(() {
        deviceList = list;
      });
    } catch (e) {
      print('Failed to fetch device list: $e');
    }
  }

  _drawer() {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 235, 231, 216),
      width: 270,
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade700),
              child: const Center(
                  child: ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Setting",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )))),
          ListTile(
            title: const Text(
              "Global Form",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            leading: const Icon(
              Icons.format_align_center,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GlobalFormPage()));
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              ))
        ],
      ),
    );
  }
}
//  _fetchDeviceList() async {
//     final ApiProvider apiProvider = ApiProvider();
//     try {
//       // final List<dynamic> list = await ApiService.fetchDeviceList();
//       final List<dynamic> list = await apiProvider.fetchData();
//       print("******////************$list");
//       setState(() {
//         deviceList = list;
//       });
//     } catch (e) {
//       print('Failed to fetch device list: $e');
//     }
//   }



  // _fetchDeviceList() async {
  //   try {
  //     final List<dynamic> list = await ApiService.fetchDeviceList();
  //     print("******////************$list");
  //     setState(() {
  //       deviceList = list;
  //     });
  //   } catch (e) {
  //     print('Failed to fetch device list: $e');
  //   }
  // }