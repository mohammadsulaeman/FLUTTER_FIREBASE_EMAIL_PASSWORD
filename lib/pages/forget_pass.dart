import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email/pages/login.dart';
import 'package:firebase_email/pages/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final _formKey = GlobalKey<FormState>();

  var email = '';
  final emailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please Cek Your Email, Password reset has been sent',
            style: TextStyle(fontSize: 18.0),
          ),
          backgroundColor: Colors.cyan,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: ((context) => LoginPage()),
        ),
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No User found for that email ');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No User found for that email',
              style: TextStyle(fontSize: 18.0, color: Colors.amber),
            ),
            backgroundColor: Colors.cyan,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reset Password '),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset("images/forget.jpg"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: const Text(
              'Reset Link will be send to your email ID',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        autofocus: false,
                        decoration: const InputDecoration(
                          labelText: ' Email ',
                          labelStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 15.0,
                          ),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!value.contains('@')) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                });
                                resetPassword();
                              }
                            },
                            child: const Text(
                              'Send Email ',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Do not have a Account',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          Signup(),
                                      transitionDuration:
                                          const Duration(seconds: 0)),
                                  (route) => false);
                            },
                            child: const Text(
                              'Signup',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
