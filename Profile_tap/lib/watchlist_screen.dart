import 'package:flutter/material.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Watch List", style: TextStyle(color: Colors.amber)),
      ),
      body: const Center(
        child: Icon(Icons.local_movies, size: 100, color: Colors.amber),
      ),
    );
  }
}
