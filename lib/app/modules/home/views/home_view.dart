import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/views/widgets/berat.dart';
import 'package:ongkir/app/modules/home/views/widgets/kotaWidget.dart';
import 'package:ongkir/app/modules/home/views/widgets/provinsiWidget.dart';

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
              ProvinsiWid(
                type: 0,
              ),
              Obx(() => controller.hiddenKotaAsal.isTrue
                  ? SizedBox()
                  : CityWid(type: 0)),
              ProvinsiWid(
                type: 1,
              ),
              Obx(() => controller.hiddenKotaTujuan.isTrue
                  ? SizedBox()
                  : CityWid(type: 1)),
              BeratBarang(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: DropdownSearch<Map<String, dynamic>>(
                  mode: Mode.BOTTOM_SHEET,
                  items: const [
                    {
                      "code": "jne",
                      "name": "Jalur Nugraha Ekakurir (JNE)",
                    },
                    {
                      "code": "tiki",
                      "name": "Titipan Kilat (TIKI)",
                    },
                    {
                      "code": "pos",
                      "name": "Perusahaan Opsional Surat (POS)",
                    },
                  ],
                  hint: "Kurir",
                  onChanged: (value) {
                    if (value != null) {
                      controller.kurir.value = value["code"];
                    } else {
                      controller.hiddenButton.value = true;
                      controller.kurir.value = "";
                    }
                  },
                  popupShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
                  itemAsString: (item) => "${item!['name']}",
                  popupItemBuilder: (context, item, isSelected) => Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "${item['name']}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.prosesData();
                },
                child: Text("CEK ONGKOS KIRIM"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  primary: Colors.red[900],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
