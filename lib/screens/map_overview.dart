import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_tracker/services/my_locator.dart';

class MapOverviewScreen extends StatefulWidget {
  const MapOverviewScreen({super.key});

  @override
  State<MapOverviewScreen> createState() => _MapOverviewScreenState();
}

class _MapOverviewScreenState extends State<MapOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Map'),
      ),
      body: Stack(
        children: [
          Expanded(
            child: StreamBuilder<Position>(
                stream: MyLocator.getLiveLocation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No location data available'));
                  }

                  Position position = snapshot.data!;
                  LatLng initialCenter = LatLng(
                    position.latitude,
                    position.longitude,
                  );

                  return FlutterMap(
                    options: MapOptions(
                      initialZoom: 9,
                      initialCenter: LatLng(
                        initialCenter.latitude,
                        initialCenter.longitude,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://www.google.cn/maps/vt?lyrs=m@189&gl=cn&x={x}&y={y}&z={z}',
                        tileDisplay: const TileDisplay.fadeIn(),
                        tileBuilder: (context, child, tile) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: child,
                          );
                        },
                      ),
                    ],
                  );
                }),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ],
      ),
    );
  }
}
