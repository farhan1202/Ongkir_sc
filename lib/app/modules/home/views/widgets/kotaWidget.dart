import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/CityModels.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class CityWid extends GetView<HomeController> {
  CityWid({
    Key? key,
    required this.type,
  }) : super(key: key);
  final int type;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: DropdownSearch<Result>(
            onFind: (text) {
              var data;
              if (type == 0) {
                data = controller.getDataCity(controller.provIdAsal.value);
              } else {
                data = controller.getDataCity(controller.provIdTujuan.value);
              }

              return data;
            },
            showClearButton: true,
            mode: Mode.BOTTOM_SHEET,
            popupShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
            hint: (type == 0)
                ? "Kota / Kabupaten Asal"
                : "Kota / Kabupaten Tujuan",
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: inputDec(),
            ),
            itemAsString: (item) => "${item!.cityName} (${item.type})",
            onChanged: (value) {
              if (value != null) {
                if (type == 0) {
                  controller.kotaIdAsal.value = int.parse(value.cityId!);
                } else {
                  controller.kotaIdTujuan.value = int.parse(value.cityId!);
                }
              } else {
                if (type == 0) {
                  controller.kotaIdAsal.value = 0;
                } else {
                  controller.kotaIdTujuan.value = 0;
                }
              }
            },
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

InputDecoration inputDec() => InputDecoration(
    hintText: "Search",
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 25,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ));
