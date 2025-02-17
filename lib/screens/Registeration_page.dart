import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                    labelText: 'First Name', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                    labelText: 'Last Name', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                    labelText: 'Confirm Password', border: OutlineInputBorder()),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              roundedButton(
                label: "Register",
                onPressed: () {
                  registerUser(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    if (passwordController.text == confirmPasswordController.text) {
      if (emailController.text.isNotEmpty &&
          isValidEmail(emailController.text) &&
          passwordController.text.length >= 6) {
        try {
          UserCredential userCredential = await auth.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          await firestore.collection('users').doc(userCredential.user?.uid).set({
            'uid': userCredential.user?.uid,
            'firstName': firstNameController.text,
            'lastName': lastNameController.text,
            'email': emailController.text,
          });

          print('Registered user: ${userCredential.user?.email}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration successful!")),
          );
        } catch (e) {
          print("Error registering: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${e.toString()}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "Please enter a valid email and a password with at least 6 characters.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match!")),
      );
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  Widget roundedButton(
      {required String label, required VoidCallback onPressed}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          child: Text(label, style: TextStyle(fontSize: 18)),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
