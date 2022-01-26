import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:weather/blocs/session/cubit/session_cubit.dart';
import 'package:weather/helper/constants/app_resource_constants.dart';
import 'package:weather/model/user/UserModel.dart';
import 'package:weather/model/weather/DailyForecasts.dart';

class TodayWeather extends StatelessWidget {
  final DailyForecasts weather;

  const TodayWeather({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = context.read<SessionCubit>().currentUser!;
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)),
        ),
        child: Center(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: ResourceConstants.deviceHeight(context) * .03,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        user.city.toString() +
                            " / " +
                            user.district!.toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.location_on,
                        size: 25,
                        color: Colors.white,
                      )
                    ]),
                    SizedBox(
                      height: ResourceConstants.deviceHeight(context) * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weather.temperature!.minimum!.value.toString() +
                              "°" +
                              " / ",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        Text(
                          weather.temperature!.maximum!.value.toString() + "°",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ResourceConstants.deviceHeight(context) * .1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.wb_sunny,
                              color: Colors.white,
                            ),
                            Text(weather.day!.iconPhrase!.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.mode_night,
                              color: Colors.white,
                            ),
                            Text(
                              weather.night!.iconPhrase!.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: ResourceConstants.deviceHeight(context) * .04,
                    ),
                  ],
                ))));
  }
}
