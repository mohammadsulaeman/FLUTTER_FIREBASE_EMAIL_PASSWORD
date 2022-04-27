import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email/pages/forget_pass.dart';
import 'package:firebase_email/pages/signup.dart';
import 'package:firebase_email/pages/user_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Login Berhasil",
        style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
      )));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => UserMain())));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No User found for that email');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No User found for that email',
              style: TextStyle(fontSize: 18.0, color: Colors.amber),
            ),
          ),
        );
      } else if (error.code == 'user does not have a password.') {
        print('Wrong password provider by the users');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Wrong password provider by the users',
              style: TextStyle(fontSize: 18.0, color: Colors.amber),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("images/login.jpg"),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.black26, fontSize: 15.0),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please enter valid Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: _isHidePassword,
                  autofocus: false,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 20.0),
                    errorStyle:
                        const TextStyle(color: Colors.black26, fontSize: 15),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglePasswordVisibility();
                      },
                      child: Icon(
                        _isHidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isHidePassword ? Colors.grey : Colors.blue,
                      ),
                    ),
                    isDense: true,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text.trim();
                            password = passwordController.text.trim();
                          });
                          userLogin();
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0, fontFamily: 'Serif'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPass(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forget Password',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Do Not Have Account ? ',
                      style:
                          TextStyle(fontSize: 20.0, color: Colors.blueAccent),
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
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
