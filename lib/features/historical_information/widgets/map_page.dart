// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    Key? key,
    required this.lati,
    required this.longi,
  }) : super(key: key);

  final double lati;
  final double longi;

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      if (error != null) {
        debugPrint('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 200;
      MapMeasure mapMeasureZoom =
          MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      hereMapController.camera
          .lookAtPointWithMeasure(GeoCoordinates(lati, longi), mapMeasureZoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: HereMap(onMapCreated: _onMapCreated),
        ),
      ),
    );
  }
}
