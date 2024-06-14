import 'dart:math';

import 'package:awchat/components/messages.dart';
import 'package:awchat/components/new_message.dart';
import 'package:awchat/core/models/chat_notification.dart';
import 'package:awchat/core/services/auth/auth_service.dart';
import 'package:awchat/core/services/notification/chat_notification_service.dart';
import 'package:awchat/page/notificationtio_page/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('AdeWeb Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
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
                }),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return NotificationPage();
                  }));
                },
                icon: Icon(Icons.notifications),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              )
            ],
          )
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Provider.of<ChatNotificationService>(context, listen: false).add(
      //         ChatNotification(
      //             title: 'primeira notificacao',
      //             body: Random().nextDouble().toString()));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
