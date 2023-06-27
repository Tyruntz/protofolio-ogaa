import 'package:flutter/material.dart';
import 'package:presensi/database_service.dart';
import 'package:presensi/home.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Silahkan Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('Login', style: TextStyle(fontSize: 30)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Masukkan Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(

                border: UnderlineInputBorder(),
                hintText: 'Masukkan Password',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                try {
                  DatabaseService().signIn(usernameController.text, passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Berhasil Login'),
                    ),
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage()));
                } catch (e) {
                 if (e == 'user-not-found') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User tidak ditemukan'),
                    ),
                  );
                 } else if (e == 'wrong-password') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password salah'),
                    ),
                  );
                 } else if (e == 'invalid-email') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email tidak valid'),
                    ),
                  );
                 } else if (e == 'user-disabled') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User dinonaktifkan'),
                    ),
                  );
                 } else if (e == 'too-many-requests') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Terlalu banyak percobaan login'),
                    ),
                  );
                 } else if (e == 'operation-not-allowed') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Operasi tidak diizinkan'),
                    ),
                  );
                 } else if (e == 'weak-password') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password terlalu lemah'),
                    ),
                  );
                 } else if (e == 'email-already-in-use') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email sudah digunakan'),
                    ),
                  );
                 } else if (e == 'invalid-email') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email tidak valid'),
                    ),
                  );
                 } else if (e == 'operation-not-allowed') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Operasi tidak diizinkan'),
                    ),
                  );
                 } else if (e == 'weak-password') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password terlalu lemah'),
                    ),
                  );
                 } else if (e == 'email-already-in-use') {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email sudah digunakan'),
                    
                    )
                  );
                }
              };
              },
              child: const Text('Login'),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Belum punya akun? Daftar disini')),
          TextButton(onPressed: (){
            showModalBottomSheet(context: context, builder: (context) => ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('Daftar', style: TextStyle(fontSize: 30)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: email,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Masukkan Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: password,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Masukkan Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      try {
                        DatabaseService().signUp(email.text, password.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Berhasil Mendaftar'),
                          ),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Gagal Mendaftar'),
                          ),
                        );
                        Navigator.pop(context);
                        print(e);
                      }
                      
                    },
                    child: const Text('Daftar'),
                  ),
                ),
              ],
            ) );
          }, child: const Text('Daftar'))
        ],
      ),
    );
  }
}
