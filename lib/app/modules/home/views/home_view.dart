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
            ],
          );
        },
      ),
    );
  }
}
