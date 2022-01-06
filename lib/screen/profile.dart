import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(this.userId, {Key? key}) : super(key: key);
  final String userId;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: ListTile(
          title: Text("Welcome ${widget.userId}"),
          subtitle: const Text("User Profile Page"),
          onTap: () => {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person),
      ),
    );
  }
}
