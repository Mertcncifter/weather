import 'package:hive/hive.dart';
import 'package:weather/model/weather/DailyForecasts.dart';

class DailtyForeCastsDatabase {
  static String _boxName = "DailyForecasts";

  static Future<Box<DailyForecasts>> invoiceBox() async {
    var box = await Hive.openBox<DailyForecasts>(_boxName);
    return box;
  }

  static Future<void> addToBox(DailyForecasts dailyForecasts) async {
    final box = await invoiceBox();
    await box.add(dailyForecasts);
  }

  static Future<void> addToBoxx(List<DailyForecasts> dailyForecasts) async {
    final box = await invoiceBox();
    await box.addAll(dailyForecasts);
  }

  static Future<List<DailyForecasts?>?> getLast() async {
    final box = await invoiceBox();
    List<DailyForecasts> dailyForecasts = box.values.toList();
    if (dailyForecasts.length >= 5) {
      return dailyForecasts.sublist(dailyForecasts.length - 5);
    }
  }
}
