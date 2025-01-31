import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';

void main() async {
  await dotenv .load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => WeatherCubit(WeatherRepository()),
        child: HomeScreen(),
      ),
    );
  }
}