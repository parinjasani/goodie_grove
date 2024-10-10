import 'package:finalyeraproject/Firebase/firebase_singleton.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CreditManagement extends StatefulWidget {
  @override
  _CreditManagementState createState() => _CreditManagementState();
}

class _CreditManagementState extends State<CreditManagement> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController profilePicUrlController = TextEditingController();
  final TextEditingController creditController = TextEditingController();

  // Method to handle registration
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      String? result = await FirebaseSingleton().registerUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        profilePicUrl: profilePicUrlController.text, // Can be null
        credit: int.parse(creditController.text),
      );

      // If result is null, registration was successful
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User registered successfully')),
        );
        // Navigate to login or dashboard

      } else {
        // If registration fails, show the error message returned
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),  // Show error message
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Management'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: profilePicUrlController,
                decoration: InputDecoration(labelText: 'Profile Picture URL'),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: creditController,
                decoration: InputDecoration(labelText: 'Credit'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter credit';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              MaterialButton(
                minWidth: 20.h,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                onPressed: () {
                  _register();
                },
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
