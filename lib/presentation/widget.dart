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
            color: const Color.fromRGBO(138, 160, 203, 1),
            border: Border.all(color: Colors.white10),
            borderRadius: BorderRadius.circular(24)),
        child: Align(alignment: Alignment.center, child: Text(msg)),
      ),
    );
  }
}

class QuickSearch extends StatelessWidget {
  const QuickSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          FamousCity(city: "Bengaluru"),
          FamousCity(city: "Kolkata"),
          FamousCity(city: "Delhi"),
          FamousCity(city: "Mumbai"),
          FamousCity(city: "Chennai"),
          FamousCity(city: "Pune"),
          FamousCity(city: "Patna"),
          FamousCity(city: "Chandigarh"),
          FamousCity(city: "Raipur"),
          FamousCity(city: "Jaipur"),
          FamousCity(city: "Faridabad"),
        ],
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class ContainerBox extends StatelessWidget {
  const ContainerBox(
      {super.key, this.child, this.height, this.width, this.padding});

  final Widget? child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 74, 94, 132)),
      child: child,
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}

class FamousCity extends StatelessWidget {
  const FamousCity({super.key, required this.city});

  final String city;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<WeatherBloc>(context).add(WeatherGetData(city: city));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return const MyHomePage();
        }), (route) => false);
      },
      child: Chip(
        side: BorderSide.none,
        backgroundColor: const Color.fromRGBO(138, 160, 203, 1),
        label: Text(city),
      ),
    );
  }
}
