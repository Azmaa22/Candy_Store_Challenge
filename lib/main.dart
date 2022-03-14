import 'package:candy_sorter/features/candy_sorter/view/configuration_page.dart';
import 'package:candy_sorter/features/candy_sorter/game_bloc/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(),
      child: MaterialApp(
        title: 'Candy Sorter',
        home: SafeArea(
          child: ConfigurationPage(),
        ),
      ),
    );
  }
}
