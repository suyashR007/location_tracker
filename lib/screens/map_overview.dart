import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_tracker/controllers/global.dart';
import 'package:location_tracker/models/geofence/geofence.dart';
import 'package:location_tracker/models/geofence/polygon.dart' as poly;
import 'package:location_tracker/repositories/my_prefs.dart';
import 'package:location_tracker/services/my_locator.dart';
import 'package:location_tracker/services/my_permission.dart';
import 'package:location_tracker/widgets/button/primary.dart';

class MapOverviewScreen extends StatefulWidget {
  const MapOverviewScreen({super.key});

  @override
  State<MapOverviewScreen> createState() => _MapOverviewScreenState();
}

class _MapOverviewScreenState extends State<MapOverviewScreen> {
  List<LatLng> polygonPoints = [];
  GeofenceModel? geofence;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (polygonPoints.isNotEmpty) {
                setState(() {
                  geofence = GeofenceModel(
                    name: 'New Geofence',
                    purpose: 'User-defined geofence',
                    polygon: [poly.Polygon(points: polygonPoints)],
                    color: 'blue',
                  );
                });
                await MyPrefs.geoRepo.addGeofence(geofence!);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<Position>(
        stream: MyLocator.getLiveLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final globalController = Get.find<GlobalController>();
            if (globalController.userLocationPermission == false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Location Permission is denied'),
                  PrimaryButton(
                    onPressed: () =>
                        MyPermissionHandler.requestLocationPermission(),
                    child: Text('Request Location Permission'),
                  )
                ],
              );
            } else {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          } else if (!snapshot.hasData) {
            return Center(child: Text('No location data available'));
          }

          Position position = snapshot.data!;
          LatLng initialCenter = LatLng(position.latitude, position.longitude);

          return FlutterMap(
            options: MapOptions(
              onTap: (tapPosition, point) {
                setState(() {
                  polygonPoints.add(point);
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              PolygonLayer(
                polygons: [
                  if (geofence != null)
                    Polygon(
                      points: geofence!.polygon!.first.points,
                      color: Colors.blue.withOpacity(0.3),
                      borderStrokeWidth: 2,
                      borderColor: Colors.blue,
                    ),
                ],
                useAltRendering: false,
                debugAltRenderer: false,
                polygonCulling: true,
                polygonLabels: true,
                drawLabelsLast: false,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            polygonPoints.clear();
            geofence = null;
          });
        },
        tooltip: 'Start Creating Geofence',
        child: const Icon(Icons.add_location),
      ),
    );
  }
}
