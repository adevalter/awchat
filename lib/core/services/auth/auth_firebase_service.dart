import 'dart:io';
import 'dart:async';

import 'package:awchat/core/services/auth/auth_service.dart';
import 'package:awchat/core/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authchanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authchanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
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
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signup(
      String name, String email, String password, File? image) async {
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );

    final auth = FirebaseAuth.instanceFor(app: signup);
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (credential.user != null) {
      // Upload Foto USer
      final imageName = '${credential.user!.uid}.jpg';
      final imageURL = await _upLoadUserImage(image, imageName);

      //2 atualizar atributos usuário.
      await credential.user?.updateDisplayName(name);
      await credential.user?.updatePhotoURL(imageURL);

      // Salvar banco de dados.
      await _saveChatUser(_toChatUser(credential.user!, imageURL));
    }
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageURL,
    });
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _upLoadUserImage(File? image, String imageName) async {
    if (image == null) return null;
    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});

    return await imageRef.getDownloadURL();
  }

  static ChatUser _toChatUser(User user, [String? imageURL]) {
    return ChatUser(
        id: user.uid,
        name: user.displayName ?? user.email!.split('@')[0],
        email: user.email!,
        imageURL: imageURL ?? user.photoURL ?? '/assets/images/avatar.png');
  }
}
