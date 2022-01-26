import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather/DailyForecasts.dart';

class ExtraWeather extends StatelessWidget {
  final DailyForecasts weather;
  final bool? checkdivider;

  const ExtraWeather({Key? key, required this.weather, this.checkdivider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateFormat('dd/MM/yyyy').format(weather.date!);
    return Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Row(
                      children: [
                        Text(
                          weather.temperature!.minimum!.value.toString() + "°",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          weather.temperature!.maximum!.value.toString() + "°",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
                !checkdivider!
                    ? Divider(thickness: 1, color: Colors.white)
                    : SizedBox()
              ],
            )));
  }
}
