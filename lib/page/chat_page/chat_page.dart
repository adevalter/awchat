import 'package:awchat/core/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('chat page'),
          ),
          TextButton(
              onPressed: () {
                AuthMockService().logout();
              },
              child: const Text('Logout'))
        ],
      ),
    );
  }
}
