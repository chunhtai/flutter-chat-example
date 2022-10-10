import 'package:chat/contacts_nav_rail.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'data.dart';
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
      debugInitialUser: const User(id: "0", firstName: 'Chun-Heng', lastName: 'Tai', email: 'chtai@google.com'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Chat',
        theme: ThemeData.dark(),
        home: const ContactsNavRail(
          selectedContactId: '1',
          child: ChatScreen(contactId: '1'),
        ),
      )
    );
  }
}
