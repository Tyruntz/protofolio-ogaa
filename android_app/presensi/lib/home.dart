import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:presensi/database_service.dart';
import 'package:presensi/login.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int current_index = 0;

  @override
  void initState() {
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
    const Text('Home'),
    const Text('Add'),
    TextButton(
      onPressed: () {
        try {
          DatabaseService().signOut();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginForm()),
            (Route<dynamic> route) => false,
          );
        } catch (e) {
          print(e.toString());
        }
      },
      child: Text('LogOut'),
    )
  ];


    return Scaffold(
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: pages.elementAt(current_index),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        index: current_index,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            current_index = index;
          });
        },
      ),
    );
  }
}
