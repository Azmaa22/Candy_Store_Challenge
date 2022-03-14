import 'package:bloc/bloc.dart';
import 'package:candy_sorter/features/candy_sorter/game_bloc/game_states.dart';
import 'package:candy_sorter/features/candy_sorter/model/color_card.dart';
import 'package:candy_sorter/features/candy_sorter/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';

class GameCubit extends Cubit<GameStates> {
  GameCubit() : super(GameInitialState());
  static GameCubit get(context) => BlocProvider.of(context);
  late List<Color> colorsList;
  late int numberOfCandies;
  late Game game;
  int numberOfCandiesSorted = 0;
  final AudioCache audioCache = AudioCache(
    prefix: 'assets/audios/',
    fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
  );
  List<ColorCard> colors = [
    ColorCard(color: Colors.green),
    ColorCard(color: Colors.red),
    ColorCard(color: Colors.blue),
    ColorCard(
      color: Colors.yellow,
    ),
    ColorCard(
      color: Colors.purple,
    ),
    ColorCard(
      color: Colors.pink,
    ),
    ColorCard(
      color: Colors.orange,
    ),
    ColorCard(
      color: Colors.cyan,
    ),
    ColorCard(
      color: Colors.teal,
    ),
  ];
  bool isWinner = false;
  void matchColor(context) {
    numberOfCandies = game.candies.length + 2;
    initGame(context, false);
    emit(CandyColorRejectedState());
    audioCache.play('wrong_sound.wav');
  }

  void chooseColor(int index) {
    colors[index].isActive = false;
    emit(ColorChooseState());
  }

  void createGame(List<Color> colorsList, int numberOfCandies, context) {
    this.colorsList = colorsList;
    this.numberOfCandies = numberOfCandies;
    initGame(context, true);

    emit(GameCreateState());
    audioCache.play('start_sound.wav');
  }

  void resetGame(context) {
    initGame(context, true);

    emit(GameResetState());
    audioCache.play('start_sound.wav');
  }

  void removeCandy(Candy candy) {
    game.removeCandy(candy);
    ++numberOfCandiesSorted;
    emit(GameRemoveCandyState());
    if (game.candies.isEmpty) {
      isWinner = true;
      audioCache.play('win_sound.wav');
    } else {
      audioCache.play('match_sound.wav');
    }
  }

  void initGame(context, firstTime) {
    game = Game(
      colors: colorsList,
      numberOfCandies: numberOfCandies,
      gameArea: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2,
      ),
    );
    isWinner = false;
    if (firstTime) {
      numberOfCandiesSorted = 0;
    }
  }
}
