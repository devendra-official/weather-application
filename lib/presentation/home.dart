import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/presentation/error.dart';
import 'package:weather/presentation/search.dart';
import 'package:weather/presentation/widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
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
        if (state is WeatherSuccess) {
          Temp list = state.forecast[0];
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                state.cityName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SearchPage();
                      }));
                    },
                    icon: const Icon(
                      Icons.search,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    ContainerBox(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.main,
                                style: const TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 30),
                              Text("${state.temp}°C",
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold)),
                              Text(state.dateTime)
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                state.weatherImage,
                                height: height / 6,
                                width: width / 3,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ContainerBox(
                      padding: const EdgeInsets.all(16),
                      height: 200,
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.timer_sharp),
                              SizedBox(width: 10),
                              Text("HOURLY FORECAST",
                                  style: TextStyle(letterSpacing: 2)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.forecast.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Text(state.convertTimeWithWeek(
                                          state.forecast[index].dttxt)),
                                      Image.asset(
                                          state.weatherImg(state
                                              .forecast[index].weather[0].id),
                                          height: 74,
                                          width: 88),
                                      Text(
                                          "${state.convertTemp(state.forecast[0].main.temp)}°C")
                                    ],
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 220,
                      child: GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 220,
                          crossAxisSpacing: 10,
                        ),
                        children: [
                          Column(
                            children: [
                              ContainerBox(
                                padding: const EdgeInsets.all(16),
                                height: 109,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      state.direction,
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                    Text(
                                      "${state.speed} km/h",
                                      style: const TextStyle(
                                        fontSize: 19,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ContainerBox(
                                padding: const EdgeInsets.all(16),
                                height: 100,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "${state.sunrise} sunrise",
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                    Text(
                                      "${state.sunset} sunset",
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ContainerBox(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                RowWidget(
                                    title: "Humidity",
                                    value: "${list.main.humidity}%"),
                                const Divider(
                                    thickness: 0.5, color: Colors.white54),
                                RowWidget(
                                    title: "Feels like",
                                    value:
                                        "${state.convertTemp(list.main.feellike)}°"),
                                const Divider(
                                    thickness: 0.5, color: Colors.white54),
                                RowWidget(
                                    title: "Visibility",
                                    value: list.visibility),
                                const Divider(
                                    thickness: 0.5, color: Colors.white54),
                                RowWidget(
                                    title: "Pressure",
                                    value: list.main.pressure),
                                const Divider(
                                    thickness: 0.5, color: Colors.white54),
                                RowWidget(
                                    title: "Ground level",
                                    value: list.main.grndLevel),
                                const Divider(
                                    thickness: 0.5, color: Colors.white54),
                              ],
                            ),
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
        return const LoadingScreen();
      },
    );
  }
}
