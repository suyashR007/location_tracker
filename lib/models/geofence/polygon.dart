import 'dart:convert';
import 'package:latlong2/latlong.dart';

class Polygon {
  List<LatLng> points;

  Polygon({required this.points});

  @override
  String toString() => 'Polygon(points: $points)';

  Map<String, dynamic> toMap() {
    return {
      'points': points
          .map((point) => {'lat': point.latitude, 'lng': point.longitude})
          .toList(),
    };
  }

  factory Polygon.fromMap(Map<String, dynamic> data) {
    return Polygon(
      points: (data['points'] as List<dynamic>)
          .map((point) => LatLng(point['lat'], point['lng']))
          .toList(),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Polygon].
  factory Polygon.fromJson(String data) {
    return Polygon.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Polygon] to a JSON string.
  String toJson() => json.encode(toMap());

  Polygon copyWith({
    List<LatLng>? points,
  }) {
    return Polygon(
      points: points ?? this.points,
    );
  }
}
