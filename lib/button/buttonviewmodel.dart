import 'dart:developer' as lo;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vector_math/vector_math.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:app_settings/app_settings.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

class ViewModel extends GetxController {
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  RxDouble apiLat = 17.72470.obs;
  // RxDouble apiLat = 17.72193172257086.obs;
  RxDouble apiLng = 83.31859.obs;
  // RxDouble apiLng = 83.31056258542571.obs;
  // 16.994651523347848, 81.80809617157473
  double earthRadius = 6371000;

//Using pLat and pLng as dummy location
  double pLat = 22.8965265;
  double pLng = 76.2545445;

  late GoogleMapController mapController;
  RxMap<String, Marker> markers = <String, Marker>{}.obs;
  LatLng? initialPos;
  RxList<LatLng> polyLines = <LatLng>[].obs;
  RxBool isInSelectedArea = false.obs;

  @override
  void onInit() {
    super.onInit();
    generatePolyLines();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      AppSettings.openLocationSettings();
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position pos = await Geolocator.getCurrentPosition();
    lat.value = pos.latitude;
    lng.value = pos.longitude;
    lo.log("lng is ${lng.value}");
    // initialPos = LatLng(pos.latitude, pos.longitude);
    initialPos = const LatLng(17.72048196324308, 83.3108957138746);

    return pos;
  }

  getDist() {
    return Geolocator.distanceBetween(
        apiLat.value, apiLng.value, lat.value, lng.value);
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getDistance() {
    var distancebtwtwopoints = sqrt(
        pow(apiLat.value - lat.value, 2) + pow(apiLng.value - lng.value, 2));
    print("The distance between two given point are $distancebtwtwopoints");

    var dLat = radians(17.72024 - 17.72196);
    var dLng = radians(83.30887 - 83.31034);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(radians(lat.value)) *
            cos(radians(pLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = earthRadius * c;
    debugPrint("the distance is ${d / 1000}"); //d is the distance in meters

    double distinMts =
        Geolocator.distanceBetween(17.72024, 83.30887, 17.72196, 83.31034);
    debugPrint("the plugin dist $distinMts");
  }
}

extension Markerss on ViewModel {
  addMarkers(String id, LatLng location) {
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        draggable: true,
        onDragEnd: (updatedLocation) {
          checkLocation(updatedLocation);
          update();
        });
    markers[id] = marker;
    update();
  }

  generatePolyLines() {
    polyLines.value = [
      const LatLng(17.720417, 83.310955),
      const LatLng(17.720449, 83.310816),
      const LatLng(17.720576496200568, 83.31081591815482),
      const LatLng(17.720562444007253, 83.31095606358068),
    ];
  }

  checkLocation(LatLng point) {
    List<mp.LatLng> convertedPolyLines = polyLines
        .map((element) => mp.LatLng(element.latitude, element.longitude))
        .toList();
    isInSelectedArea.value = mp.PolygonUtil.containsLocation(
        mp.LatLng(point.latitude, point.longitude), convertedPolyLines, false);
    debugPrint("called ${isInSelectedArea.value}");
    update();
  }
}
