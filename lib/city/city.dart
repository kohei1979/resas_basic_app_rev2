import 'package:resas_project_app/city/city_type.dart';

class City {
  City({
    required this.prefCode,
    required this.cityCode,
    required this.cityName,
    required this.cityType,
  });

  // 今回の肝で、JSONを引数に取り中身をそれぞれ展開しCityクラスに変換して返却しています。
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      prefCode: json['prefCode'] as int,
      cityCode: json['cityCode'] as String,
      cityName: json['cityName'] as String,
      cityType: CityType.values[int.parse(json['bigCityFlag'] as String)],
    );
  }

  int prefCode;
  String cityCode;
  String cityName;
  CityType cityType;
}
