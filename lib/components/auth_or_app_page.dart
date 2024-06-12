import 'package:awchat/core/auth/auth_service.dart';
import 'package:awchat/core/models/chat_user.dart';
import 'package:awchat/page/auth_page/auth_page.dart';
import 'package:awchat/page/chat_page/chat_page.dart';
import 'package:awchat/page/loading_page/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().UserChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return snapshot.hasData ? ChatPage() : AuthPage();
          }
        },
      ),
    );
  }
}
