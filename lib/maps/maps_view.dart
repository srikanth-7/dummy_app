import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../button/buttonviewmodel.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  ViewModel ctrlr = Get.put(ViewModel());
  @override
  Widget build(BuildContext context) {
    ctrlr.determinePosition();
    return Obx(
      () => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: ctrlr.initialPos!,
                    zoom: 20,
                  ),
                  onMapCreated: (controller) => [
                        ctrlr.mapController = controller,
                        ctrlr.addMarkers("test", ctrlr.initialPos!)
                      ],
                  markers: ctrlr.markers.values.toSet(),
                  // circles: {
                  //   Circle(
                  //       circleId: const CircleId("1"),
                  //       center: ctrlr.initialPos!,
                  //       radius: 320,
                  //       strokeWidth: 2,
                  //       fillColor: Colors.blue.withOpacity(0.1))
                  // },
                  polygons: {
                    Polygon(
                      polygonId: const PolygonId("1"),
                      points: ctrlr.polyLines,
                      fillColor: Colors.blue.shade100,
                      strokeWidth: 2,
                    ),
                  }),
            ),
            Text(
              ctrlr.isInSelectedArea.value ? "within" : "outside",
              style: const TextStyle(fontSize: 50),
            )
          ],
        ),
      ),
    );
  }
}
