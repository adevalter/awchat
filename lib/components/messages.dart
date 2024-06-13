import 'package:awchat/components/message_bubble.dart';
import 'package:awchat/core/services/auth/auth_service.dart';
import 'package:awchat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder(
      stream: ChatService().messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Sem Dados. Vamos Conversar"),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
              reverse: true,
              itemCount: msgs.length,
              itemBuilder: (ctx, i) => MessageBubble(
                  key: ValueKey(msgs[i].id),
                  message: msgs[i],
                  belongsToCurrentUser: currentUser?.id == msgs[i].userId));
        }
      },
    );
  }
}
