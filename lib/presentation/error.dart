import 'package:flutter/material.dart';
import 'package:weather/main.dart';
import 'package:weather/presentation/widget.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key,this.errormsg = "something went wrong"});

  final String errormsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errormsg),
            const SizedBox(height: 18),
            ContainerButton(
                msg: "Try Again",
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return const MyApp();
                  }), (route) => false);
                })
          ],
        ),
      ),
    );
  }
}
