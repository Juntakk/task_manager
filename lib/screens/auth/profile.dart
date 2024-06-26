import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/auth/auth.dart';

class Profile extends StatefulWidget {
  Profile({super.key, required this.user});

  User user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Logging out"),
            content: const SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Are you sure you want to log out ?"),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ),
                  );
                  FirebaseAuth.instance.signOut();
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: _showDialog,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                tileColor: Theme.of(context).hoverColor,
                title: const Text("Email"),
                subtitle: Text(
                  widget.user.email.toString(),
                ),
                leading: const Icon(Icons.email_outlined),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                tileColor: Theme.of(context).hoverColor,
                title: const Text("ID"),
                subtitle: Text(
                  widget.user.uid,
                ),
                leading: const Icon(Icons.numbers_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
