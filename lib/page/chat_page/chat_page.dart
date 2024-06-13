import 'package:awchat/components/messages.dart';
import 'package:awchat/components/new_message.dart';
import 'package:awchat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('AdeWeb Chat'),
          actions: [
            DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                items: [
                  DropdownMenuItem(
                      value: 'logout',
                      child: Container(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.black87,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Sair')
                          ],
                        ),
                      ))
                ],
                onChanged: (value) {
                  if (value == 'logout') {
                    AuthService().logout();
                  }
                })
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
        ));
  }
}
