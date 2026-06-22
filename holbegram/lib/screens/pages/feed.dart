import 'package:flutter/material.dart';
import 'package:holbegram/utils/posts.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Holbegram",
              style: TextStyle(fontFamily: "Billabong", fontSize: 35),
            ),
            Image(
              image: AssetImage('assets/images/logo.webp'),
              width: 60,
              height: 40,
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message_outlined),
          ),
        ],
      ),
      body: Posts()
    );
  }
}
