import 'package:hive/hive.dart';
import 'package:weather/model/user/UserModel.dart';

class UserDatabase {
  static String _boxName = "User";
  static Future<Box<UserModel>> invoiceBox() async {
    var box = await Hive.openBox<UserModel>(_boxName);
    return box;
  }

  static Future<UserModel?> getUser() async {
    final box = await invoiceBox();
    if (box.values.length != 0) {
      UserModel user = box.values.first;
      return user;
    }
  }

  static Future<void> addToBox(UserModel user) async {
    final box = await invoiceBox();
    await box.add(user);
  }

  static Future<void> updateBox(
      String city, String district, String cityId) async {
    final box = await invoiceBox();
    var uid = box.getAt(0)!.uid;
    await box.putAt(
        0, UserModel(uid: uid, city: city, district: district, cityId: cityId));
  }

  static Future<void> deleteAll() async {
    final box = await invoiceBox();
    await box.clear();
  }
}
