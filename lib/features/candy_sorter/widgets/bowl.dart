import 'package:candy_sorter/features/candy_sorter/widgets/colored_svg.dart';
import 'package:flutter/material.dart';

class Bowl extends StatefulWidget {
  const Bowl({
    Key? key,
    this.color = Colors.black,
    this.width = 130,
  }) : super(key: key);

  final Color color;
  final double width;

  @override
  State<Bowl> createState() => _BowlState();
}

class _BowlState extends State<Bowl> {
  int numberOfCandiesInBowl = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DragTarget<Color>(
        builder: (context, candidateData, rejectedData) {
          return Stack(
            children: [
              ColoredSvg(
                path: 'assets/images/bowl.svg',
                color: widget.color,
                width: widget.width,
              ),
              Positioned(
                top: 20,
                left: 55,
                child: Text(
                  '$numberOfCandiesInBowl',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
        },
        onWillAccept: (data) {
          return data == widget.color;
        },
        onAccept: (data) {
          setState(() {
            ++numberOfCandiesInBowl;
          });
        },
      ),
    );
  }
}
