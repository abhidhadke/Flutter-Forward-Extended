import 'package:flutter/material.dart';
import 'package:flutter_forward_extended/Components/RoundedButton.dart';
import '../Components/formField.dart';
import '../Constants.dart' as constants;
import 'package:firebase_auth/firebase_auth.dart';

import 'Weather.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _auth = FirebaseAuth.instance;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: constants.nightPrimary,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image(
              image: const AssetImage('assets/images/Weather.png'),
              width: size.width,
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.75,
                    child: formField(
                      size: size,
                      text: 'E-mail',
                      //password: false,
                      onChanged: (value) {
                        email = value;
                      },
                      isPassword: false,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.75,
                    child: formField(
                      size: size,
                      text: 'Password',
                      isPassword: true,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                    child: RoundedButton(
                      text: 'Login',
                      press: () async {
                        try {
                          final newUser = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          print(newUser.toString());
                          if (newUser != null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Weather()));
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      color: constants.dayPrimary,
                      textColor: constants.nightPrimary,
                      length: size * 0.55,
                      fontsize: 30,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: constants.dayPrimaryFade,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
