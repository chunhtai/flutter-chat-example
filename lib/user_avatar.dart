import 'package:flutter/material.dart';

import 'data.dart' show User;

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const CircleAvatar(
        backgroundColor: Colors.grey,
      );
    }
    // Hash name into a color.
    final int red = user!.firstName.codeUnits.reduce((value, element) => value + element);
    final int green = user!.lastName.codeUnits.reduce((value, element) => value + element);
    final Color backGroundColor = Color.fromARGB(255, red % 256, green % 256, 255);
    return CircleAvatar(
      backgroundColor: backGroundColor,
      foregroundColor: Colors.white,
      child: Text('${user!.firstName[0]}${user!.lastName[0]}'),
    );

  }
}