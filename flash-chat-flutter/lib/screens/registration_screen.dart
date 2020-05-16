import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../components/round_button.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  String email;
  String password;

  bool isObscure = true;

  void updateShowSpinner(bool value) {
    setState(() {
      showSpinner = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 300.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: isObscure,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  suffixIcon: isObscure
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = false;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                            size: 24,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = true;
                            });
                          },
                          icon: Icon(
                            Icons.visibility_off,
                            size: 24,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                color: Colors.blueAccent,
                title: 'Register',
                onPressed: () async {
                  updateShowSpinner(true);
                  try {
                    final user = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                  updateShowSpinner(false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
