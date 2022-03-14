import 'package:candy_sorter/features/candy_sorter/game_bloc/game_cubit.dart';
import 'package:candy_sorter/features/candy_sorter/game_bloc/game_states.dart';
import 'package:candy_sorter/features/candy_sorter/view/bowl_area.dart';
import 'package:candy_sorter/features/candy_sorter/view/candy_area.dart';
import 'package:candy_sorter/features/candy_sorter/view/configuration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<GameCubit, GameStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: ElevatedButton(
                onPressed: () {
                  GameCubit.get(context).resetGame(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfigurationPage(),
                    ),
                  );
                },
                child: const Text('New Game'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Candies left: ${GameCubit.get(context).game.candies.length}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Candies sorted: ${GameCubit.get(context).numberOfCandiesSorted}',
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: GameCubit.get(context).isWinner
                  ? Image.asset('assets/images/stars.gif')
                  : CandyArea(
                      game: GameCubit.get(context).game,
                      remover: GameCubit.get(context).removeCandy,
                    ),
            ),
            Expanded(
              child: BowlArea(
                game: GameCubit.get(context).game,
              ),
            ),
          ],
        );
      },
    ));
  }
}
