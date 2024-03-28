import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 62, 175, 219),
        title: const Text(
          "Resister",
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
          child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient:
                const LinearGradient(transform: GradientRotation(8), colors: [
              Color.fromARGB(255, 253, 240, 202),
              Color.fromARGB(255, 231, 238, 248),
            ])),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please Enter name";
                  }
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please Enter name";
                  }
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please Enter name";
                  }
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please Enter name";
                  }
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
            const Center(
                child: Text(
              "* All fields are Required.",
              style: TextStyle(color: Colors.black),
            )),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                height: 30,
                width: 200,
                child: Container(
                  child: ElevatedButton(
                      style: const ButtonStyle(),
                      onPressed: () {},
                      child: const Text("Create an Account")),
                ))
          ],
        ),
      )),
    );
  }
}
