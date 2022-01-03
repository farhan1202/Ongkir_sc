import 'package:get/get.dart';
import 'package:ongkir/app/data/models/CityModels.dart' as kotaModel;
import 'package:ongkir/app/data/models/ProvinceModel.dart';
import 'package:ongkir/app/data/providers/rajaOngkirApi.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var hiddenKota = true.obs;
  var provId = 0.obs;

  RxList<Result> province = List<Result>.empty().obs;
  RxList<kotaModel.Result> city = List<kotaModel.Result>.empty().obs;

  Future<RxList<Result>> getData() async {
    province.clear();

    var response = await RajaOngkirApi().getAllProvince();

    if (response!.rajaongkir!.results != null) {
      response.rajaongkir!.results?.forEach((element) {
        province.add(element);
      });
    }

    return province;
  }

  Future<RxList<kotaModel.Result>> getDataCity(int provId) async {
    city.clear();

    var response = await RajaOngkirApi().getAllCity(provId);
    if (response!.rajaongkir!.results != null) {
      response.rajaongkir!.results?.forEach((element) {
        city.add(element);
      });
    }

    return city;
  }
}
