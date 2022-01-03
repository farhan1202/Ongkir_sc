import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/data/models/ProvinceModel.dart';

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
            return Center(child: Text("Loading"));
          }
          return Container(
            padding: EdgeInsets.all(15),
            child: DropdownSearch<Result>(
              mode: Mode.BOTTOM_SHEET,
              popupShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
              items: controller.province,
              hint: "Provinsi Asal",
              onChanged: (value) => print(value?.province),
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
        },
      ),
    );
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
}
