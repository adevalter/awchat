import 'dart:io';

import 'package:awchat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  static const _defaultImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble(
      {super.key, required this.message, required this.belongsToCurrentUser});

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);
    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 220,
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.grey.shade300
                    : Theme.of(context).primaryColor,
                borderRadius: belongsToCurrentUser
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(0),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(12),
                      ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    textAlign:
                        belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    message.text,
                    style: TextStyle(
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 165,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(message.userImageURL),
        ),
      ],
    );
  }
}
