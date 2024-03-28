import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddDevice extends StatefulWidget {
  ScanResult deviceList;
  AddDevice({super.key, required this.deviceList});
  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  // Initial Selected Value
  List<dynamic> deviceList = [];

  String _selectedItem = '';
  final TextEditingController xController = TextEditingController();
  final TextEditingController yController = TextEditingController();
  final TextEditingController gatewayController = TextEditingController();
  final TextEditingController devicetypeController = TextEditingController();
  final String url = "192.168.1.148:5000/api/v1/add-devices";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setDropDownValue();
  }

  setDropDownValue() {
    setState(() {
      gatewayController.text = widget.deviceList.device.id.id;
    });
  }

  Future<void> postData() async {
    try {
      print("function called -----------------$url");
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'device_mac_address': gatewayController.value.text,
            'device_type': devicetypeController.value.text,
            'x_coordinate': double.parse(xController.value.text),
            'y_coordinate': double.parse(yController.value.text)
          }));
      print("response is ---------------------${response.body}");
      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Data Posted Successfully");
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      setState(() {
        String result = 'Error: $e';
      });
    }
  }
  List<String> deviceType =['Gateway','Assets Tracker'];
  String isSelectedValue ='Gateway';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Device',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              DropdownButton<String>(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                dropdownColor: Colors.grey.shade300,
                value: _selectedItem.isEmpty ? null : _selectedItem,
                hint: const Text(
                  'Select device type',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                items:
                    <String>['Assets Tracker', 'Getaway'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue!;
                  });
                },
              ),
              if (_selectedItem == 'Getaway') ...[
                const SizedBox(
                  height: 100,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: gatewayController,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                              labelText: "Gateway",
                              labelStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the value';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: DropdownButton(
                        //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                        //     value: isSelectedValue,
                        //     items: deviceType.map<DropdownMenuItem<String>>((String value)
                        //     {
                        //       return DropdownMenuItem(
                        //         value:value,
                        //         child: const Text("Device Type"));
                        //     }).toList(),
                        //    onChanged: (String? newValue){
                        //     setState(() {
                        //       isSelectedValue=newValue!;
                        //     });
                        //    }),
                        // ),
                        TextFormField(
                          controller: devicetypeController,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                              labelText: "Device Type",
                              labelStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300)),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the value';
                            }
                          },
                        ),
                        TextFormField(
                          controller: xController,
                          decoration:
                              const InputDecoration(labelText: 'X Coordinate'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the value';
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: yController,
                          decoration:
                              const InputDecoration(labelText: 'Y Coordinate'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the value';
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              postData();
                              Fluttertoast.showToast(
                                  msg: 'Device Data Submitted SUccessfully');
                              gatewayController.clear();
                              devicetypeController.clear();
                              xController.clear();
                              yController.clear();
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

















// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';


// class DeviceIdCheckScreen extends StatefulWidget {
//   // BluetoothDevice? connectedDevice;
//    const DeviceIdCheckScreen( {super.key,});

//    @override
//   State<DeviceIdCheckScreen> createState() => _DeviceIdCheckScreenState();
// }

// class _DeviceIdCheckScreenState extends State<DeviceIdCheckScreen> {
//   String deviceId = '';
//   String deviceType = '';

//   void checkDeviceId() {
//     if (deviceId.startsWith('G')) {
//       setState(() {
//         deviceType = 'Gateway';
//       });
//     } else if (deviceId.startsWith('A')) {
//       setState(() {
//         deviceType = 'Asset Tracker';
//       });
//     } else {
//       setState(() {
//         deviceType = 'Unknown';
//       });
//     }
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Device Type'),
//           content: Text('The device with ID $deviceId is a $deviceType.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Device ID Checker'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               decoration: InputDecoration(labelText: 'Enter Device ID'),
//               onChanged: (value) {
//                 setState(() {
//                   deviceId = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 checkDeviceId();
//               },
//               child: Text('Check Device Type'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }