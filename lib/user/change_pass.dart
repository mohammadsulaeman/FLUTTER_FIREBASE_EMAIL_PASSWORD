import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePass extends StatefulWidget {
  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = '';
  final newPasswordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black87,
          content: Text(
            'Your password has been Changed.. Login again',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
      );
    } on FirebaseAuthException catch (error) {}
  }

  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/change.jpg"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  obscureText: _isHidePassword,
                  autofocus: false,
                  controller: newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter new password';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    labelText: 'New Password',
                    hintText: 'Enter New Password Minimal 6 Karakter',
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      newPassword = newPasswordController.text;
                    });
                    changePassword();
                  }
                },
                child: const Text(
                  ' Change Password ',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
