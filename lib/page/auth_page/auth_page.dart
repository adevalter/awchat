import 'package:awchat/components/auth_form.dart';
import 'package:awchat/core/services/auth/auth_service.dart';
import 'package:awchat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;
  Future<void> _handleSubmit(AuthFormData _formData) async {
    try {
      if (!mounted) return;
      setState(() => isLoading = true);
      if (_formData.isLogin) {
        await AuthService().login(
          _formData.email,
          _formData.password,
        );
      } else {
        await AuthService().signup(
          _formData.name,
          _formData.email,
          _formData.password,
          _formData.image,
        );
      }
    } catch (error) {
      //
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: [
        Center(
          child: SingleChildScrollView(
            child: AuthForm(onSubmit: _handleSubmit),
          ),
        ),
        if (isLoading == true)
          Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
            child: const Center(child: CircularProgressIndicator()),
          )
      ]),
    );
  }
}
