import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  var email = '';
  var password = '';
  var confirmPassword = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  registerUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Register Success',
            style: TextStyle(fontSize: 20.0, color: Colors.lightBlueAccent),
          ),
        ),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        print('Password is too weak');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Password is too weak',
              style: TextStyle(fontSize: 20.0, color: Colors.amber),
            ),
          ),
        );
      } else if (error.code == 'email-already-in-use') {
        print('Account is already exists');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account is already exists',
              style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
            ),
          ),
        );
      } else if (error.code == 'password and confirm password not match') {
        print('Password and confirm password doest not match');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Password and confirm password doest not match',
              style: TextStyle(fontSize: 18.0, color: Colors.amber),
            ),
          ),
        );
      }
    }
  }

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
                padding: const EdgeInsets.all(30.0),
                child: Image.asset("images/signup.png"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(fontSize: 15, color: Colors.black26),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  obscureText: _isHidePassword,
                  autofocus: false,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password minimal 6 karakter';
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
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Center(
                  child: Text(
                    'Password Minimal 6 Karakter',
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  obscureText: _isHidePassword,
                  autofocus: false,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter confirm password minimal 6 karakter';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    labelText: 'Confirm Password',
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
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                            confirmPassword = confirmPasswordController.text;
                          });
                          registerUser();
                        }
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(fontSize: 18.0, fontFamily: 'Serif'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    const Text(
                      'Already Have Account !',
                      style:
                          TextStyle(fontSize: 18.0, color: Colors.cyanAccent),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0, color: Colors.cyan),
                      ),
                    ),
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
