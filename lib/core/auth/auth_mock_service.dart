import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:awchat/core/auth/auth_service.dart';
import 'package:awchat/core/models/chat_user.dart';

class AuthMockService implements AuthService {
  static final _defaulUser = ChatUser(
    id: '122',
    name: 'DotCom',
    email: 'teste@teste.com',
    imageUrl: '/assets/image/avatar/png',
  );
  static final Map<String, ChatUser> _users = {
    _defaulUser.email: _defaulUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaulUser);
  });
  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(
      String name, String email, String pasword, File? image) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? '/assets/images/avatar.png',
    );
    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
