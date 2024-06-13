import 'package:awchat/core/auth/auth_service.dart';
import 'package:awchat/core/services/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String message = '';
  final _messageConstroller = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;
    if (user != null) {
      ChatService().save(message, user);
    }
    _messageConstroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageConstroller,
            onChanged: (msg) => setState(() => message = msg),
            decoration: const InputDecoration(labelText: 'Enviar Mensagem ...'),
            onSubmitted: (_) {
              if (message.trim().isNotEmpty) {
                _sendMessage();
              }
            },
          ),
        ),
        IconButton(
            onPressed: message.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send))
      ],
    );
  }
}
