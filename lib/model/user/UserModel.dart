import 'package:hive/hive.dart';
part 'UserModel.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? uid;
  @HiveField(1)
  String? city;
  @HiveField(2)
  String? district;
  @HiveField(3)
  String? cityId;
  UserModel({this.uid, this.city, this.district, this.cityId});
}
