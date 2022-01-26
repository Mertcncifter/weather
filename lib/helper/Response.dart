import 'package:weather/helper/constants/enums.dart';
import 'package:weather/model/weather/DailyForecasts.dart';

class WeatherResponse {
  List<DailyForecasts>? Data;
  ResponseState? Error;

  WeatherResponse({this.Data, this.Error});

  static WeatherResponse SuccessWithData(List<DailyForecasts> data) {
    return new WeatherResponse(Data: data);
  }

  static WeatherResponse Fail(ResponseState state) {
    return new WeatherResponse(Error: state);
  }
}
