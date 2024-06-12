import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Entrar')),
            TextButton(
                onPressed: () {}, child: const Text('Criar uma nova conta ?'))
          ],
        )),
      ),
    );
  }
}
