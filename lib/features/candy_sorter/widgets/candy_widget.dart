import 'package:candy_sorter/features/candy_sorter/game_bloc/game_cubit.dart';
import 'package:candy_sorter/features/candy_sorter/game_bloc/game_states.dart';
import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:candy_sorter/features/candy_sorter/widgets/colored_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CandyWidget extends StatelessWidget {
  const CandyWidget({
    Key? key,
    required this.candy,
    required this.onDragCompleted,
    this.width = 30,
  }) : super(key: key);

  final Candy candy;
  final double width;
  final Function() onDragCompleted;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameStates>(
        builder: (context, state) {
          return Draggable<Color>(
            data: candy.color,
            child: ColoredSvg(
              path: 'assets/images/candy.svg',
              color: candy.color,
              width: width,
            ),
            feedback: Container(
              height: 100,
              width: 100,
              child: ColoredSvg(
                path: 'assets/images/candy.svg',
                color: candy.color,
                width: width,
              ),
            ),
            childWhenDragging: ColoredSvg(
              path: 'assets/images/candy.svg',
              color: Colors.grey,
              width: width,
            ),
            onDragCompleted: onDragCompleted,
            onDraggableCanceled: (velocity, offset) {
              print('velocity $velocity');
              print('state $state');
              GameCubit.get(context).matchColor(context);
            },
          );
        },
        listener: (context, state) {});
  }
}
