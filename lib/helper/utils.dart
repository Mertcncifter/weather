import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/model/user/UserModel.dart';
import 'package:weather/model/weather/DailyForecasts.dart';
import 'package:weather/model/weather/Day.dart';
import 'package:weather/model/weather/Inum.dart';
import 'package:weather/model/weather/Temperature.dart';

class Utils {
  static Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      return true;
    }
    return false;
  }

  static Future<void> Box() async {
    await Hive.initFlutter();
    Hive.registerAdapter<UserModel>(UserModelAdapter());
    await Hive.openBox<UserModel>("User");

    Hive.registerAdapter<Day>(DayAdapter());
    await Hive.openBox<Day>("Day");

    Hive.registerAdapter<Imum>(ImumAdapter());
    await Hive.openBox<Imum>("Imum");

    Hive.registerAdapter<Temperature>(TemperatureAdapter());
    await Hive.openBox<Temperature>("Temperature");

    Hive.registerAdapter<DailyForecasts>(DailyForecastsAdapter());
    await Hive.openBox<DailyForecasts>("DailyForecasts");
  }
}
