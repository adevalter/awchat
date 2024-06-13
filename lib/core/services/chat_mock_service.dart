import 'dart:async';
import 'dart:math';

import 'package:awchat/core/models/chat_message.dart';
import 'package:awchat/core/models/chat_user.dart';
import 'package:awchat/core/services/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
        id: '1',
        text: "Boa Noite",
        createdAt: DateTime.now(),
        userId: '121',
        userName: 'PontoCom',
        userImageURL: 'assets/images/avatar.png'),
    ChatMessage(
        id: '2',
        text: "Boa Noite Tudo Bem",
        createdAt: DateTime.now(),
        userId: '122',
        userName: 'DotCom',
        userImageURL: 'assets/images/avatar.png'),
    ChatMessage(
        id: '3',
        text: "Boa Noite Tudo e ai",
        createdAt: DateTime.now(),
        userId: '123',
        userName: 'Claudia',
        userImageURL: 'assets/images/avatar.png'),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller!.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
        id: Random().nextDouble().toString(),
        text: text,
        createdAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageURL: user.imageUrl);
    _msgs.add(newMessage);
    _controller!.add(_msgs);
    return newMessage;
  }
}
