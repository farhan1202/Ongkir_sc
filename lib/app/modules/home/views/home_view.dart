import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/data/models/ProvinceModel.dart';
import 'package:ongkir/app/data/models/CityModels.dart' as kotaModel;

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkir Indonesia'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: EdgeInsets.all(15),
            children: [
              ProvinsiWid(),
              Obx(() => controller.hiddenKota.isTrue ? SizedBox() : CityWid()),
            ],
          );
        },
      ),
    );
  }
}

InputDecoration inputDec() => InputDecoration(
    hintText: "Search",
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 25,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ));

class ProvinsiWid extends StatelessWidget {
  var controller = Get.find<HomeController>();
  ProvinsiWid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownSearch<Result>(
        showClearButton: true,
        mode: Mode.BOTTOM_SHEET,
        popupShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )),
        items: controller.province,
        hint: "Provinsi Asal",
        onChanged: (value) {
          if (value != null) {
            print(value.province);
            controller.hiddenKota.value = false;
            controller.provId.value = int.parse(value.provinceId!);
          } else {
            print("tidak memilik apapun");
            controller.hiddenKota.value = true;
            controller.provId.value = 0;
          }
        },
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: inputDec(),
        ),
        itemAsString: (item) => item!.province!,
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              "${item.province}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}

class CityWid extends StatelessWidget {
  var controller = Get.find<HomeController>();
  CityWid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: DropdownSearch<kotaModel.Result>(
            onFind: (text) {
              var data = controller.getDataCity(controller.provId.value);
              return data;
            },
            showClearButton: true,
            mode: Mode.BOTTOM_SHEET,
            popupShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
            hint: "Kota / Kabupaten Asal",
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: inputDec(),
            ),
            itemAsString: (item) => "${item!.cityName} (${item.type})",
            popupItemBuilder: (context, item, isSelected) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  "${item.cityName} (${item.type})",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }));
  }
}
