import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class GlobalFormPage extends StatefulWidget {
  const GlobalFormPage({super.key});

  @override
  State<GlobalFormPage> createState() => _GlobalFormPageState();
}

class _GlobalFormPageState extends State<GlobalFormPage> {
  @override
  Widget build(BuildContext context) {
    String url = "http://192.168.1.148:5000/api/v1/constant-value";
    TextEditingController nFactorController = TextEditingController();
    TextEditingController cvalueController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    @override
    void initState() {
      super.initState();
    }

    Future<void> postData() async {
      try {
        print("function called -----------------$url");
        final response = await http.post(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'N': double.parse(nFactorController.value.text),
              'c': double.parse(cvalueController.value.text),
            }));
        print("response is ---------------------${response.body}");
        if (response.statusCode == 201) {
          Fluttertoast.showToast(msg: "Data Posted Successfully");
        } else {
          throw Exception('Failed to post data');
        }
        nFactorController.clear();
        cvalueController.clear();
      } catch (e) {
        setState(() {
          String result = 'Error: $e';
        });
      }
    }

    @override
    void dispose() {
      nFactorController.dispose();
      cvalueController.dispose();

      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "N-Factor:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Field is required';
                  }
                  if (double.parse(value) <= 1.9 ||
                      double.parse(value) >= 4.1) {
                    return 'Enter a value between 2 and 4 range';
                  }
                  return null;
                },
                // validator: (value) {
                //   print("value is ---------------------${value.runtimeType}");
                //   double number = double.parse(value!);
                //   if (number == null || number.toString().isEmpty) {
                //     return "Field is required";
                //   } else if (number >= 2.0 && number <= 4.0) {
                //     return null;
                //   }
                //   return 'Enter a value between 2 and 4';
                // },
                controller: nFactorController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter N Factor'),
              ),
              const SizedBox(
                height: 20,
              ),
              /////////////
              const Text(
                "c:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Field is required';
                  }
                  return null;
                },
                controller: cvalueController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter distance between two gateways'),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        postData();
                        Fluttertoast.showToast(msg: "Submitted Successfully");                     }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
