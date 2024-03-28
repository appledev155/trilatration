import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:trilateration/modules/measured_Pow/model/measuredpow_model.dart';

class MeasuredPowerd extends StatefulWidget {
  final dynamic deviceInfo;
  const MeasuredPowerd({super.key, this.deviceInfo});

  @override
  State<MeasuredPowerd> createState() => _MyFormState();
}

class _MyFormState extends State<MeasuredPowerd> {
  final String url =
      "http://192.168.1.100:5000/api/v1/measured_power_device_data";
  final _formKey = GlobalKey<FormState>();
  final gatewayController = TextEditingController();
  final assetTrackerController = TextEditingController();
  final rssiController = TextEditingController();
  // mp_store.MeasuredPowerRow measurePowStore = mp_store.MeasuredPowerRow();

  // Dropdown options
  final List<Gateway> gateways = [
    Gateway('40D63CBA428C'),
    Gateway('40D63CD4AEF2'),
    Gateway('40D63CD4AF10'),
    Gateway('40D63CD4F206'),
    Gateway("40D63CB529E7")
  ];
  final List<AssetDevice> assetDevices = [
    AssetDevice('F8F9B942D63B'),
  ];

  @override
  void initState() {
    super.initState();
    setDropDownValue();
  }

  setDropDownValue() {
    setState(() {
      gatewayController.text = widget.deviceInfo['device_mac_address'];
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
            'ga_mac': gatewayController.value.text,
            'dt_mac': assetTrackerController.value.text,
            'measured_power': rssiController.value.text,
          }));
      print("response is ---------------------${response.body}");
      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: "Data Posted Successfully");
      } else {
        throw Exception('Failed to post data');
      }
      // gatewayController.clear();
      // assetTrackerController.clear();
      // rssiController.clear();
    } catch (e) {
      setState(() {
        String result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("data------------------------${widget.deviceInfo}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text('Calculate Measured Power'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Select Gateway:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<Gateway>(
                  hint: Text(
                    gatewayController.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  items:
                      gateways.map<DropdownMenuItem<Gateway>>((Gateway value) {
                    return DropdownMenuItem<Gateway>(
                      value: value,
                      child: Text(value.id),
                    );
                  }).toList(),
                  onChanged: (Gateway? value) {
                    gatewayController.text = value!.id.toString();
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Select Asset Device:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                DropdownButtonFormField<AssetDevice>(
                  value: null,
                  hint: const Text("Select asset device"),
                  items: assetDevices
                      .map<DropdownMenuItem<AssetDevice>>((AssetDevice value) {
                    return DropdownMenuItem<AssetDevice>(
                      value: value,
                      child: Text(value.id),
                    );
                  }).toList(),
                  onChanged: (AssetDevice? value) {
                    assetTrackerController.text = value!.id.toString();
                  },
                ),
                const SizedBox(height: 21),
                const Text('Measured Power:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: rssiController,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 3)),
                    hintText: 'Enter Rssi value at 1 meter',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*this field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      postData();
                      Fluttertoast.showToast(
                          msg: 'Data Submitted Successfully');
                      const Duration(seconds: 15);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const DeviceTracker()));
                    }

                    setState(() {
                      gatewayController.clear();
                      assetTrackerController.clear();
                      rssiController.clear();
                    });
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 // MeasuredPower measurePowerDetails = MeasuredPower(
                  //     assetsDevice: gatewayController.text,
                  //     rssi: int.parse(rssiController.text),
                  //     gateway: assetTrackerController.text);
                  //     await measurePowStore.saveMeasuredPow(measurePowerDetails);
                  // print("====================");

                  // Fluttertoast.showToast(msg: "Submitted Successfully");
                  // gatewayController.clear();
                  // assetTrackerController.clear();
                  // rssiController.clear();