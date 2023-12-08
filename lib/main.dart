import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/presentation/error.dart';
import 'package:weather/presentation/home.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(BlocProvider(
    create: (context) => WeatherBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(WeatherGetData());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        if (state is WeatherFailure) {
          return ErrorPage(errormsg: state.error);
        }
        if (state is WeatherSuccess) {
          return const MyHomePage();
        }
        return const ErrorPage();
      }),
    );
  }
}
