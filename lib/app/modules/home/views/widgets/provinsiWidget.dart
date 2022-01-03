import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/data/models/ProvinceModel.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class ProvinsiWid extends GetView<HomeController> {
  const ProvinsiWid({required this.type, Key? key}) : super(key: key);

  final int type;

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
        hint: type == 0 ? "Provinsi Asal" : "Provinsi Tujuan",
        onChanged: (value) {
          if (value != null) {
            print(value.province);
            if (type == 0) {
              controller.hiddenKotaAsal.value = false;
              controller.provIdAsal.value = int.parse(value.provinceId!);
            } else {
              controller.hiddenKotaTujuan.value = false;
              controller.provIdTujuan.value = int.parse(value.provinceId!);
            }
          } else {
            if (type == 0) {
              controller.hiddenKotaAsal.value = true;
              controller.provIdAsal.value = 0;
              controller.kotaIdAsal.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provIdTujuan.value = 0;
              controller.kotaIdTujuan.value = 0;
            }
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

InputDecoration inputDec() => InputDecoration(
    hintText: "Search",
    contentPadding: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 25,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ));
