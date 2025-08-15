import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/bg.jpg', // Ganti dengan path gambar kamu
          ),
          fit: BoxFit.cover, // Agar gambar memenuhi layar
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 36.0),
        child: CustomScrollView(
          slivers: [SliverList(delegate: SliverChildListDelegate(children))],
        ),
      ),
    );
  }
}
