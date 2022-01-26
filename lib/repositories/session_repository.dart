import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/api/WeatherApi.dart';
import 'package:weather/database/dailyforecasts_database.dart';
import 'package:weather/database/user_database.dart';
import 'package:weather/helper/Response.dart';
import 'package:weather/helper/constants/enums.dart';
import 'package:weather/helper/utils.dart';
import 'package:weather/model/user/UserModel.dart';
import 'package:weather/model/weather/DailyForecasts.dart';

class SessionRepository {
  static Future<UserModel?> attemptAutoLogin() async {
    return UserDatabase.getUser();
  }

  static Future<UserModel?> login(String email, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    UserDatabase.addToBox(UserModel(uid: user.user!.uid));
    return UserModel(uid: user.user!.uid);
  }

  static Future<UserModel?> signUp(String email, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserDatabase.addToBox(UserModel(uid: user.user!.uid));
    return UserModel(uid: user.user!.uid);
  }

  static Future<WeatherResponse?> getWeathers(String? cityId) async {
    if (await Utils.checkConnectivity()) {
      if (cityId == null) {
        ResponseState? responseState = await checkPermission();
        if (responseState == ResponseState.locationgranted) {
          cityId = await getCityId(await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high));
        } else {
          return WeatherResponse.Fail(responseState!);
        }
      }
      if (cityId == null) {
        return WeatherResponse.Fail(ResponseState.noneConnection);
      }
      var _getDaily = await getDaily(cityId);
      if (_getDaily != null) {
        return WeatherResponse.SuccessWithData(_getDaily);
      } else {
        return WeatherResponse.Fail(ResponseState.emptydata);
      }
    } else {
      return WeatherResponse.Fail(ResponseState.noneConnection);
    }
  }

  static Future<String?> getCityId(Position position) async {
    String? response;
    await WeatherApi.ioGetCityId(
        "" +
            position.latitude.toString() +
            ", " +
            position.longitude.toString() +
            "", (jsonDyn) {
      response = jsonDyn["Key"];

      UserDatabase.updateBox(
          jsonDyn["AdministrativeArea"]["EnglishName"].toString(),
          jsonDyn["EnglishName"].toString(),
          jsonDyn["Key"]);
    }, (message) {});
    return response;
  }

  static Future<List<DailyForecasts>?> getDaily(String cityId) async {
    List<DailyForecasts>? response;
    await WeatherApi.ioGetDailyForecasts(cityId, (jsonDyn) {
      final weather = (jsonDyn['DailyForecasts'] as List)
          .map((i) => new DailyForecasts.fromJson(i));
      DailtyForeCastsDatabase.addToBoxx(weather.toList());
      response = weather.toList();
    }, (message) async {
      print(message);
    });
    return response;
  }

  static Future<ResponseState?> checkPermission() async {
    ResponseState? state;
    dynamic status;
    if (await Permission.locationWhenInUse.status == PermissionStatus.denied) {
      status = await Permission.locationWhenInUse.request();
    } else {
      status = await Permission.locationWhenInUse.status;
    }
    switch (status) {
      case PermissionStatus.granted:
        state = ResponseState.locationgranted;
        break;
      case PermissionStatus.denied:
        state = ResponseState.locationdenied;
        break;
      case PermissionStatus.permanentlyDenied:
        state = ResponseState.locationpermanentlyDenied;
        break;
      default:
    }
    return state;
  }

  static Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    UserDatabase.deleteAll();
  }
}
