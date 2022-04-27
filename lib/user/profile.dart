import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_email/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;
  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has been sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(fontSize: 20.0, color: Colors.lightGreen),
          ),
          backgroundColor: Colors.black26,
        ),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset("images/profile.png"),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Column(
            children: [
              Text(
                'User ID: ',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                uid,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email : $email',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                    ),
                  ),
                  user!.emailVerified
                      ? Text(
                          ' Verified ',
                          style: TextStyle(fontSize: 13.0),
                        )
                      : TextButton(
                          onPressed: () => {verifyEmail()},
                          child: const Text(
                            'Verify Email ',
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.lightBlue),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Column(
                children: [
                  Text(
                    ' Created : ',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  Text(creationTime.toString())
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
