import 'package:shared_preferences/shared_preferences.dart';
import 'package:location_tracker/models/geofence/geofence.dart';

class GeoFenceRepository {
  final SharedPreferences instance;

  GeoFenceRepository(this.instance);

  Future<void> saveGeofences(List<GeofenceModel> geofences) async {
    List<String> geofenceJsonList =
        geofences.map((geofence) => geofence.toJson()).toList();
    await instance.setStringList('geofences', geofenceJsonList);
  }

  Future<void> addGeofence(GeofenceModel geofence) async {
    List<GeofenceModel> currentGeofences = fetchGeofences();
    currentGeofences.add(geofence);
    await saveGeofences(currentGeofences);
  }

  List<GeofenceModel> fetchGeofences() {
    List<String>? geofenceJsonList = instance.getStringList('geofences');
    if (geofenceJsonList != null) {
      return geofenceJsonList
          .map((geofenceJson) => GeofenceModel.fromJson(geofenceJson))
          .toList();
    }
    return [];
  }
}
