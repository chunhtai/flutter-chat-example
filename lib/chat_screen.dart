import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'auth.dart';
import 'user_avatar.dart';

class ChatHistory {
  const ChatHistory({
    required this.message,
    required this.isOutgoing,
    required this.timestamp,
  });

  final String message;
  final bool isOutgoing;
  final DateTime timestamp;
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.contactId});

  final String contactId;

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late List<ChatHistory> history;
  late User contact;
  User? currentUser;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadChat();
  }

  void _loadChat() {
    history = <ChatHistory>[];
    if (chatHistory.containsKey(widget.contactId)) {
      for (dynamic message in chatHistory[widget.contactId] as List<dynamic>) {
        history.add(
            ChatHistory(
              message: message['message'] as String,
              isOutgoing: message['outgoing'] as bool,
              timestamp: DateTime.fromMillisecondsSinceEpoch(
                  int.parse(message['time'] as String) * 1000),
            )
        );
      }
    }
    contact = contacts[widget.contactId]!;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentUser = StreamAuthScope.of(context).currentUser;
  }

  @override
  void didUpdateWidget(ChatScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.contactId != widget.contactId) {
      _loadChat();
    }
  }

  void _handleNewMessage(String? message) {
    if (message == null) {
      return;
    }
    controller.clear();
    setState(() {
      history.add(
        ChatHistory(
          message: message,
          isOutgoing: true,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  Widget _buildContactAvatarSection() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          UserAvatar(user: contact),
          Text(
            '${contact.firstName} ${contact.lastName}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ),
          Text(contact.email, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w200)),
          const SizedBox(height: 30),
          const Text.rich(TextSpan(
            children: <InlineSpan>[WidgetSpan(child: Icon(size: 13, Icons.history)), TextSpan(text: ' HISTORY IS ON')],
          ), style: TextStyle(fontSize: 13),),
          const Text('Messages sent with history on are saved', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200)),
          const SizedBox(height: 20),
        ],
      )
    );
  }

  Widget _buildAppbarLeading() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text.rich(
          TextSpan(
            text: '${contact.firstName} ${contact.lastName}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            children: const <InlineSpan>[WidgetSpan(child: Icon(Icons.keyboard_arrow_down_sharp, size: 15))],
          ),
        ),
      ),
    );
  }

  Widget _buildChatHistory() {
    final List<Widget> children = <Widget>[
      _buildContactAvatarSection(),
    ];
    for (final ChatHistory historyEntry in history) {
      final User? owner = historyEntry.isOutgoing ? currentUser : contact;
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formattedTime = formatter.format(historyEntry.timestamp);
      children.add(const SizedBox(height: 15));
      children.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: SizedBox(
                width: 25,
                height: 25,
                child: UserAvatar(user: owner),
              ),
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(text: '${owner?.firstName} ${owner?.lastName} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: formattedTime, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w200)),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(historyEntry.message),
              ],
            )),
          ],
        ),
      );
    }
    return ListView(

      reverse: true,
      children: children.reversed.toList(),
    );
  }

  Widget _buildTextField() {
    return Row(
      children: [
        const Icon(Icons.add_circle_outline),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            onSubmitted: _handleNewMessage,
            decoration: const InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)))
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.send),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Scaffold(
        appBar: AppBar(leading: _buildAppbarLeading(), leadingWidth: 300),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double chatHistoryPadding = constraints.maxWidth * 0.15;
            final double textFieldPadding = constraints.maxWidth * 0.12;
            return Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: chatHistoryPadding, right: chatHistoryPadding),
                      child: Column(
                        children: <Widget>[
                          Expanded(child: _buildChatHistory()),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: textFieldPadding, right: textFieldPadding),
                    child: _buildTextField(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
