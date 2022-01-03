import 'package:get/get.dart';
import 'package:ongkir/app/data/models/CityModels.dart';
import 'package:ongkir/app/data/models/ProvinceModel.dart';
import 'package:ongkir/app/data/providers/rajaOngkirApi.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxList<Result> province = List<Result>.empty().obs;
  RxList<ResultCity> city = List<ResultCity>.empty().obs;

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
}
