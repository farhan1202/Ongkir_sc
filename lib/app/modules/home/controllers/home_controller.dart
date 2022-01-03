import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/CityModels.dart' as kotaModel;
import 'package:ongkir/app/data/models/ProvinceModel.dart';
import 'package:ongkir/app/data/providers/rajaOngkirApi.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var hiddenKotaAsal = true.obs;
  var provIdAsal = 0.obs;
  var kotaIdAsal = 0.obs;

  var hiddenKotaTujuan = true.obs;
  var provIdTujuan = 0.obs;
  var kotaIdTujuan = 0.obs;

  var hiddenButton = true.obs;
  var kurir = "".obs;

  late TextEditingController beratC;
  double berat = 0;
  String satuan = "gram";

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;

    switch (cekSatuan) {
      case "gram":
        berat = berat;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      default:
        berat = berat;
    }

    print("$berat gram");
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case "gram":
        berat = berat;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      default:
        berat = berat;
    }

    satuan = value;
    print("$berat gram");
  }

  void prosesData() {
    if (kotaIdAsal != 0 && kotaIdTujuan != 0 && berat > 0 && kurir != "") {
      Get.defaultDialog(title: "Perhatian", middleText: "$kurir");
    } else {
      Get.defaultDialog(title: "Perhatian", middleText: "Harap Isi Semua Data");
      RajaOngkirApi().getCost("501", "114", "1700", "jne").then((value) {
        print(value.body);
      });
    }
  }

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

  @override
  void onInit() {
    // TODO: implement onInit
    beratC = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    beratC.dispose();
    super.onClose();
  }
}
