import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/cubit/location_cubit.dart';
import 'package:weather/model/location_model.dart';
import 'package:weather/presentation/error.dart';
import 'package:weather/presentation/home.dart';
import 'package:weather/presentation/widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextField(
            controller: search,
            onSubmitted: (value) {
              BlocProvider.of<WeatherBloc>(context)
                  .add(WeatherGetData(city: value));
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return const MyHomePage();
              }), (route) => false);
            },
            onChanged: (value) {
              if (value.isEmpty) {
                BlocProvider.of<LocationCubit>(context).searchcity("");
              } else {
                BlocProvider.of<LocationCubit>(context).searchcity(value);
              }
            },
            decoration: const InputDecoration(
                hintText: "Search City",
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none),
          )),
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(
              child: Text("searching..."),
            );
          }
          if (state is LocationSuccess) {
            List<LocationList> list = state.cityList;
            if (list.isEmpty) {
              return const QuickSearch();
            } else {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      state.cityList = [];
                      BlocProvider.of<WeatherBloc>(context)
                          .add(WeatherGetData(city: list[index].localizedName));
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return const MyHomePage();
                      }), (route) => false);
                    },
                    title: Text(list[index].localizedName),
                    subtitle: Text(
                        "${list[index].administrativeArea.localizedName}, ${list[index].country.localizedName}"),
                  );
                },
              );
            }
          }
          if (state is LocationFailed) {
            return ErrorPage(errormsg: state.msg);
          }
          return const QuickSearch();
        },
      ),
    );
  }
}
