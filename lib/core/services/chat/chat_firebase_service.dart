import 'dart:async';
import 'dart:math';

import 'package:awchat/core/models/chat_message.dart';
import 'package:awchat/core/models/chat_user.dart';
import 'package:awchat/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    //chatmsg  => Map<String, dynamic>
    final msg = ChatMessage(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userimageURL: user.imageURL,
    );

    final docRef = await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(msg);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(
    ChatMessage msg,
    SetOptions? options,
  ) {
    return {
      'text': msg.text,
      'createdAt': msg.createdAt.toIso8601String(),
      'userId': msg.userId,
      'userName': msg.userName,
      'userimageURL': msg.userimageURL,
    };
  }

  ChatMessage _fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? GetOptions) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      userimageURL: doc['userimageURL'],
    );
  }
}
