import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('favorite view'),
      ),
      body: const Center(
        child: Text('FavoriteView'),
      ),
    );
  }
}
