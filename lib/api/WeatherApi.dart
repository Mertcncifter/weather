import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class WeatherApi {
  static final _base = "http://dataservice.accuweather.com";
  static final _apiKey = "XUB4xx5a8JRUejHx25gK2fEpr1Gcveeu";

  static Future ioGetCityId(String q, Function(dynamic jsonDyn) successTrue,
      Function(dynamic message) successFalse) async {
    try {
      var url =
          '$_base/locations/v1/cities/geoposition/search?apikey=$_apiKey&q=$q&language=tr-tr';
      http.Response response = await http.get(Uri.parse(url));
      switch (response.statusCode) {
        case 200: // OK
          dynamic jsonDyn = json.decode((response.body));
          await successTrue(jsonDyn);
          break;
        default:
          await successFalse({"Beklenmedik bir hata oluştu"});
          break;
      }
    } catch (e) {
      await successFalse({"Beklenmedik bir hata oluştu"});
    } finally {}
  }

  static Future ioGetDailyForecasts(
      String cityId,
      Function(dynamic jsonDyn) successTrue,
      Function(dynamic message) successFalse) async {
    try {
      var url =
          '$_base/forecasts/v1/daily/5day/$cityId?apikey=$_apiKey&language=tr-tr&metric=true';
      http.Response response = await http.get(Uri.parse(url));
      switch (response.statusCode) {
        case 200: // OK
          dynamic jsonDyn = json.decode((response.body));
          await successTrue(jsonDyn);
          //final weather = (jsonDyn['DailyForecasts'] as List)
          //    .map((i) => new DailyForecasts.fromJson(i));
          break;
        default:
          await successFalse({"Beklenmedik bir hata oluştu"});
          break;
      }
    } catch (e) {
      await successFalse({"Beklenmedik bir hata oluştu"});
    } finally {}
  }
}
