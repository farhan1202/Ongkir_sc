import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: controller.beratC,
          onChanged: (value) => controller.ubahBerat(value),
          autocorrect: false,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: "Berat",
            border: OutlineInputBorder(),
          ),
        )),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 150,
          child: DropdownSearch<String>(
            mode: Mode.BOTTOM_SHEET,
            showSearchBox: true,
            items: [
              "gram",
              "kg",
            ],
            hint: "Satuan",
            onChanged: (value) => controller.ubahSatuan(value!),
            selectedItem: "gram",
            popupShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
            searchFieldProps: TextFieldProps(
              decoration: inputDec(),
            ),
          ),
        )
      ],
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
