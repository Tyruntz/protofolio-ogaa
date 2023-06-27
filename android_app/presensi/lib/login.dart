import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Silahkan Login'),
      
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Username'),
          TextField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Masukkan Username',
            ),
          ),
          const Text('Password'),
          TextField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Masukkan Password',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              
            },
            child: const Text('Login'),
          ),
        ],
      ),
      
    );
  }
}