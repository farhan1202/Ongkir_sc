import 'package:get/get.dart';
import 'package:ongkir/app/data/models/CityModels.dart';
import 'package:ongkir/app/data/models/ProvinceModel.dart';

class RajaOngkirApi extends GetConnect {
  final url = "https://api.rajaongkir.com/starter/";
  final key = "92d2e17845732cf95b99d9a2e517c78e";

  Future<Province?> getAllProvince() async {
    final response = await get(
      url + "province",
      headers: {"key": key},
    );

    Province province;
    province = Province.fromJson(response.body);

    return province;
  }

  Future<City?> getAllCity(int provId) async {
    final response = await get(
      url + "city?province=$provId",
      headers: {"key": key},
    );

    City city;
    city = City.fromJson(response.body);

    return city;
  }
}
