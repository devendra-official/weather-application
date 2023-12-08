import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/presentation/home.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({super.key, required this.msg, required this.onTap});
  final String msg;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 48,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          border: Border.all(),
          borderRadius: BorderRadius.circular(24)
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(msg)),
      ),
    );
  }
}
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          width: double.infinity,
          child: TextField(
            controller: search,
            onSubmitted: (value) {
              BlocProvider.of<WeatherBloc>(context).add(WeatherGetData(city: value));
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                return const MyHomePage();
              }), (route) => false);
            },
            decoration: const InputDecoration(
                hintText: "Search for city", border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox(
      {super.key,
      required this.value,
      required this.name,
      required this.image});

  final String value;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          image,
          height: 40,
          width: 40,
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
