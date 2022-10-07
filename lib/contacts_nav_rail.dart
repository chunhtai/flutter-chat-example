import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data.dart' as data;
import 'user_avatar.dart';

class ContactsNavRail extends StatefulWidget {
  const ContactsNavRail({super.key, required this.selectedContactId, required this.child});

  final String selectedContactId;
  final Widget child;

  @override
  State<ContactsNavRail> createState() => _ContactsNavRailState();
}

class _ContactsNavRailState extends State<ContactsNavRail> {
  late List<data.User> contacts;
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() {
    contacts = <data.User>[];
    selectedIndex = 0;
    for (final String id in data.contacts.keys) {
      if (id == widget.selectedContactId) {
        selectedIndex = contacts.length;
      }
      contacts.add(data.contacts[id]!);
    }
  }



  @override
  void didUpdateWidget(ContactsNavRail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedContactId != widget.selectedContactId) {
      _loadContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                GoRouter.of(context).go('/${contacts[index].id}');
              },
              extended: true,
              leading: SizedBox(
                width: 256,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    Flexible(flex: 2, child: Text('Chat', style: TextStyle(fontWeight: FontWeight.bold))),
                    Spacer(flex: 8),
                    Flexible(flex: 1, child: Icon(Icons.add, color: Colors.green)),
                  ],
                ),
              ),
              destinations: contacts.map<NavigationRailDestination>((data.User user) {
                return NavigationRailDestination(
                  icon: UserAvatar(user: user),
                  selectedIcon: UserAvatar(user: user),
                  label: SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${user.firstName} ${user.lastName}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10),
                        if (data.chatHistory.containsKey(user.id))
                          Text(data.chatHistory[user.id][0]['message'], maxLines: 1, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w200)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const VerticalDivider(thickness: 3, width: 3),
            // This is the main content.
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
