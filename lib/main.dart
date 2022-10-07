import 'package:flutter/material.dart';

import 'auth.dart';
import 'chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamAuthScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Chat',
        theme: ThemeData.dark(),
        home: const ChatScreen(contactId: '1'),
      )
    );
  }
}
