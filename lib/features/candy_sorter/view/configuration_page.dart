import 'package:candy_sorter/features/candy_sorter/game_bloc/game_cubit.dart';
import 'package:candy_sorter/features/candy_sorter/game_bloc/game_states.dart';
import 'package:candy_sorter/features/candy_sorter/view/game_page.dart';
import 'package:candy_sorter/features/candy_sorter/widgets/color_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigurationPage extends StatelessWidget {
  ConfigurationPage({
    Key? key,
  }) : super(key: key);

  final List<Color> colorsList = [];
  final TextEditingController numberOfCandiesController =
      TextEditingController();
  static const snackBar = SnackBar(
    content: Text('Please Enter Candies Number or Choose at least one color'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Candies Game'),
        ),
        body: BlocConsumer<GameCubit, GameStates>(builder: (context, state) {
          GameCubit myCubit = GameCubit.get(context);
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: TextFormField(
                    controller: numberOfCandiesController,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: 'Please enter Number of Candies',
                        labelText: 'Candies Number'),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const Text(
                  'Please Choose your favorite colors ',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(myCubit.colors.length, (index) {
                      return Center(
                          child: ColorContainer(
                        currentColor: myCubit.colors[index],
                        onPress: () {
                          colorsList.add(myCubit.colors[index].color);
                          myCubit.chooseColor(index);
                        },
                      ));
                    }),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    if (colorsList.isEmpty ||
                        int.parse(numberOfCandiesController.text) == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      myCubit.createGame(colorsList,
                          int.parse(numberOfCandiesController.text), context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GamePage(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Start Game',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }, listener: (context, state) {
          print('current state $state');
        }));
  }
}
