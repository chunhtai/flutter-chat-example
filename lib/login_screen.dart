import 'package:flutter/material.dart';

import 'auth.dart';
import 'data.dart';

/// The login screen.
class LoginScreen extends StatefulWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool loggingIn = false;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Sign In to Flutter Chat.')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (loggingIn)
            const CircularProgressIndicator(),
          if (!loggingIn)
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loggingIn = true;
                });
                await StreamAuthScope.of(context).signIn(const User(id: "0", firstName: 'Chun-Heng', lastName: 'Tai', email: 'chtai@google.com'));
                setState(() {
                  loggingIn = false;
                });
              },
              child: const Text('Login'),
            ),
        ],
      ),
    ),
  );
}