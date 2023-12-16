import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/cubit/location_cubit.dart';
import 'package:weather/presentation/error.dart';
import 'package:weather/presentation/home.dart';
import 'package:weather/presentation/search.dart';
import 'package:weather/presentation/widget.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => WeatherBloc()),
        BlocProvider(create: (context) => LocationCubit()),
      ],
      child: const MyApp(),
    ),
  );
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
      theme: ThemeData(
          colorSchemeSeed: const Color.fromARGB(255, 84, 109, 169),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 66, 87, 135)),
          scaffoldBackgroundColor: const Color.fromARGB(255, 66, 87, 135),
          brightness: Brightness.dark,
          useMaterial3: true),
      home: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherSuccess) {
            return const MyHomePage();
          }
          if (state is WeatherLoading) {
            return const LoadingScreen();
          }
          if (state is WeatherFailure) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return const SearchPage();
                      }), (route) => false);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              body: ErrorPage(errormsg: state.error),
            );
          }
          return const SearchPage();
        },
      ),
    );
  }
}
