import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class NextBrandMark extends StatelessWidget {
  const NextBrandMark({super.key, this.size = 54});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * .27),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6475FF), AppColors.primary, Color(0xFF3346C4)],
        ),
        boxShadow: const [BoxShadow(color: Color(0x224659EC), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              'N',
              style: TextStyle(
                color: Colors.white,
                fontSize: size * .54,
                fontWeight: FontWeight.w900,
                letterSpacing: -size * .045,
                height: 1,
              ),
            ),
          ),
          Positioned(
            right: size * .20,
            top: size * .17,
            child: Container(
              width: size * .1,
              height: size * .1,
              decoration: const BoxDecoration(color: Color(0xFF59E4D4), shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}

class NextBrandName extends StatelessWidget {
  const NextBrandName({super.key, this.light = false, this.fontSize = 24});
  final bool light;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: 'Next', style: TextStyle(color: light ? Colors.white : AppColors.navy)),
        TextSpan(text: 'Contábil', style: TextStyle(color: light ? AppColors.mint : AppColors.primary)),
      ]),
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w800, letterSpacing: -.9),
    );
  }
}
