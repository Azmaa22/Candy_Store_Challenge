import 'package:candy_sorter/features/candy_sorter/model/color_card.dart';
import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  final ColorCard currentColor;
  final Function onPress;
  final double width;
  final double height;

  const ColorContainer({
    Key? key,
    required this.currentColor,
    required this.onPress,
    this.width = 100,
    this.height = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        currentColor.isActive ? onPress() : () {};
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: currentColor.isActive
              ? currentColor.color
              : currentColor.color.withOpacity(0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
