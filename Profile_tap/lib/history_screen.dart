import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<String> historyMovies = const [
    "assets/images/2789e32778ee40c478653a08575f1705160e1370.jpg",
    "assets/images/fb9bf22334e0e1f803a486647774e3547ef6bb68.jpg",
    "assets/images/62a91993882ebf7b39030a68c87492f1e5e33643.jpg",
    "assets/images/86f26d4030fde3c1f75ced95c72d1892e444e5f4.jpg",
    "assets/images/b5f1175a7c201f41e00d36644eaff1923c50b99f.jpg",
    "assets/images/0fe2c40b8b8b084cd943470d3df2af7b040e8f9b.jpg",
    "assets/images/a2f655d74e9a24e5d0fc67d124cf34a8651b97e9.jpg",
    "assets/images/df8110e521909190d74f2a8738f3cd9db3a70978.png",
    "assets/images/c0f290d047153021cd9d2c2f4f3a6cebc0fb62b7.jpg",
    "assets/images/4a254f17dde787053a77faceee0072956dcded22.jpg",
    "assets/images/bc77125aec13b4bc2bd9d1bfd3b8677f66864d1a.jpg",
    "assets/images/55cc203f8e1ef2c35809036ccde54c2bc163ba99.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("History", style: TextStyle(color: Colors.amber)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: historyMovies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  historyMovies[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 14),
                      SizedBox(width: 2),
                      Text("7.7", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
