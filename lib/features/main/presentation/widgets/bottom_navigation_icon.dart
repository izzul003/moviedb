import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationIcon extends StatelessWidget {
  final String image;
  final Color color;

  const BottomNavigationIcon({
    super.key,
    required this.image,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: SvgPicture.asset(
        image,
        width: 24,
        height: 24,
        color: color,
      ),
    );
  }
}
