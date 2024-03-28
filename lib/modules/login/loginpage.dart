
import 'package:flutter/material.dart';
import 'package:trilateration/modules/home/get_device_list.dart';
import 'package:trilateration/modules/login/pages/create_acc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 222, 150),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(53, 62, 226, 0.6),
                      boxShadow:const [ BoxShadow(color: Colors.grey, spreadRadius: 3)],
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 100.0)),
                    ),
                    child: Stack(children: [
                     
                      Positioned(
                          child: Container(
                        margin: const EdgeInsets.only(right: 200),
                        child: const Center(
                            child: Text("Login",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 236, 180, 11)))),
                      )),
                    ])),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 222, 150),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromARGB(255, 230, 190, 111)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 170, 170, 160),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              border:
                                  Border(bottom: BorderSide(color: Colors.grey))),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please Enter value';
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter Email",
                                hintStyle: TextStyle(color: Colors.grey.shade700),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please Enter Password';
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password??",
                      style: TextStyle(color: Color.fromRGBO(90, 97, 230, 1)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: 40,
                    width: 280,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const DeviceListScreen())));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          )),
                    )),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateAccount()));
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(color: Color.fromRGBO(90, 97, 230, 1)),
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
