import 'package:get/get.dart';
import 'package:ongkir/app/data/models/CityModels.dart';
import 'package:ongkir/app/data/models/CostModels.dart';
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

  Future<Cost?> getCost(
      int origin, int destinetion, String weight, String courier) async {
    final form = FormData({
      'origin': origin,
      'destination': destinetion,
      'weight': weight,
      'courier': courier
    });

    var data = await post(url + "cost", form, headers: {
      'key': key,
      // 'content-type': 'application/x-www-form-urlencoded'
    });

    Cost cost;
    cost = Cost.fromJson(data.body);

    return cost;
  }
}
