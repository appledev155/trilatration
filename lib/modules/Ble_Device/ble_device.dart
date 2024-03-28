import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:trilateration/modules/Ble_Device/ble_controller.dart';
import 'package:trilateration/modules/home/add_device.dart';


class BleDevice extends StatefulWidget {
   BleDevice({super.key});

   final Map<Guid, List<int>> readValues = <Guid, List<int>>{};

  @override
  State<BleDevice> createState() => _BleDeviceState();
}

class _BleDeviceState extends State<BleDevice> {
  BluetoothDevice? _connectedDevice;
  final List<BluetoothService> _services = [];
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> devicesList = <ScanResult>[];
  List<ScanResult> searchList = <ScanResult>[];

  TextEditingController searchController = TextEditingController();
  String searchText = '';

  void getDeviceList(List<ScanResult> data) {
    devicesList = data;
  }

  void _searchDevice() {
    String searchText = searchController.text.trim();
    // ScanResult? device;
    setState(() {
      searchList = [];
    });
    try {
      devicesList.forEach((element) {
        if (element.device.id
            .toString()
            .contains(searchText.toString().toUpperCase())) {
          print('Device found: ${element.device}');

          setState(() {
            searchList.add(element);
          });
          log("search list================${element.device.id}--------------$searchText");
        }
      });

      // device = devicesList.firstWhere(
      //   (device) =>
      //       device.device.id.toString().contains(searchText.toUpperCase())||
      //       device.device.id.id.toString().contains(searchText.toUpperCase()),
      //   // orElse: () => null,
      // );
      setState(() {});
    } catch (er) {
      Fluttertoast.showToast(msg: "Device Not Found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          title: const Text("BLE SCANNER"),
          centerTitle: true,
        ),
        body: _buildView());
  }

  _buildView() {
    if (_connectedDevice != null) {
      // return addDeviceList();
    }
    return deviceList();
  }

  _buildConnectDeviceView() {
    List<Widget> containers = <Widget>[];

    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget = <Widget>[];

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        characteristicsWidget.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(characteristic.uuid.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    ..._buildReadWriteNotifyButton(characteristic),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Value: ${widget.readValues[characteristic.uuid]}'),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        );
      }
      containers.add(
        ExpansionTile(
            title: Text(service.uuid.toString()),
            children: characteristicsWidget),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  List<ButtonTheme> _buildReadWriteNotifyButton(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = <ButtonTheme>[];

    if (characteristic.properties.read) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Wrap(children: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                child:
                    const Text('READ', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  var sub = characteristic.value.listen((value) {
                    setState(() {
                      widget.readValues[characteristic.uuid] = value;
                    });
                  });
                  await characteristic.read();
                  sub.cancel();
                },
              ),
            ]),
          ),
        ),
      );
    }

    return buttons;
  }

  deviceList() {
    return GetBuilder<BleController>(
      init: BleController(),
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) => _searchDevice(),
                decoration: InputDecoration(
                  labelText: 'Search by Identifier or MAC Address',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchDevice,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: const Size(100, 40)),
                    onPressed: () {
                      setState(() {
                        searchList = [];
                        searchController.clear();
                      });
                      controller.scanDevices();
                    },
                    child: const Text(
                      "Scan",
                      style: TextStyle(fontSize: 19, color: Colors.black),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            (searchList.isEmpty)
                ? StreamBuilder<List<ScanResult>>(
                    stream: controller.ScanResults,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                getDeviceList(snapshot.data!);
                                print("////////////////////$data");
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: 2,
                                      child: ListTile(
                                        title: Text(data.device.name == ''
                                            ? '(Unknow Device)'
                                            : data.device.name),
                                        subtitle: Text(data.device.id.id),
                                        trailing: Text(data.rssi.toString()),
                                        leading: TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.blue),
                                            onPressed: () async {
                                               flutterBlue.stopScan();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddDevice(
                                                              deviceList:
                                                                  data)));
                                            },
                                            child: const Text(
                                              "Add",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        );
                      } else {
                        return const Center(
                          child: Text("No Device Found"),
                        );
                      }
                    })
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          final data = searchList[index];
                          // getDeviceList(snapshot.data!);
                          // print("////////////////////$data");
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(data.device.name == ''
                                      ? '(Unknow Device)'
                                      : data.device.name),
                                  subtitle: Text(data.device.id.id),
                                  trailing: Text(data.rssi.toString()),
                                  leading: TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      onPressed: () async {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => AddDevice(
                                        //             deviceList: data)));

                                        setState(() {
                                          searchController.clear();
                                        });
                                      },
                                      child: const Text(
                                        "Add",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
          ],
        );
      },
    );
  }

  // addDeviceList() {
  //   return ElevatedButton(
  //       onPressed: () {
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) =>  AddDevice( _connectedDevice)));
  //       },
  //       child: const Text(
  //         "Add",
  //         style: TextStyle(color: Colors.black, fontSize: 16),
  //       ));
  // }
}
