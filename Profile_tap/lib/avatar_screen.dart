import 'package:flutter/material.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key});

  final List<String> avatars = const [
    "assets/avatars/0ecb0264ed6bae405d7a1f06d2b702842000ca23.png",
    "assets/avatars/8ada4b5e9db6fa638fd610ae56566f29347fa6cc.png",
    "assets/avatars/9efa2883c85d008343fb6de73f1c7d828598c10b.png",
    "assets/avatars/22b644fc9582b0f4009d71c4fba3af8de2d76fa5.png",
    "assets/avatars/76e0002b86723433e7e92b593252d92865c77fe2.png",
    "assets/avatars/1781d833130f2d6e86fdf74b18fe8f84e378b3a2.png",
    "assets/avatars/9634d5f2c8b153c8df68558ef338ba799147bc12.png",
    "assets/avatars/26200766c8c2f003179d12c5221ee05a7b84c7ef.png",
    "assets/avatars/72248670caa99b64a8fe19db3b62d70ebc10f1dc.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Choose Avatar", style: TextStyle(color: Colors.amber)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: avatars.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.pop(context, avatars[index]),
            child: CircleAvatar(
              backgroundImage: AssetImage(avatars[index]),
              radius: 40,
            ),
          );
        },
      ),
    );
  }
}
