import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/presentation/error.dart';
import 'package:weather/presentation/widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
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
          Temp list = state.forecast[0];
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text(state.cityName),
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SearchPage();
                      }));
                    },
                    icon: const Icon(Icons.search),
                  )
                ]),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(state.weatherImage,
                            height: h / 4, width: w / 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.main,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.normal),
                            ),
                            Text('${state.temp}°C',
                                style: const TextStyle(
                                    fontSize: 42, fontWeight: FontWeight.bold)),
                            Text(state.dateTime)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 148,
                      child: ListView.builder(
                          itemCount: state.forecast.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 128,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: const Color.fromRGBO(41, 41, 41, 1)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.convertTimeWithWeek(
                                      state.forecast[index].dttxt)),
                                  Image.asset(
                                    state.weatherImg(
                                        state.forecast[index].weather[0].id),
                                    height: 78,
                                    width: 78,
                                  ),
                                  Text(
                                    "${state.convertTemp(state.forecast[index].main.temp)}°C",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      height: 260,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(41, 41, 41, 1),
                          borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InfoBox(
                                  image: "assets/weather images/humidity.png",
                                  value: list.main.humidity,
                                  name: "Humidity"),
                              InfoBox(
                                  image: "assets/weather images/pressure.png",
                                  value: list.main.pressure,
                                  name: "Pressure"),
                              InfoBox(
                                image: "assets/weather images/visibility.png",
                                value: list.visibility,
                                name: "Visibility",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InfoBox(
                                  image: "assets/weather images/sea level.png",
                                  value: list.main.seaLevel,
                                  name: "Sea level"),
                              InfoBox(
                                  image:
                                      "assets/weather images/ground level.png",
                                  value: list.main.grndLevel,
                                  name: "Ground level"),
                              InfoBox(
                                image: "assets/weather images/wind speed.png",
                                value: list.wind.speed,
                                name: "Wind Speed",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color.fromRGBO(41, 41, 41, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.sunrise,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Text("Sunrise"),
                            ],
                          ),
                          Image.asset(
                            "assets/weather images/sun.png",
                            height: 100,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.sunset,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Text("Sunset"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const ErrorPage();
      },
    );
  }
}
