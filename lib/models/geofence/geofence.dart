import 'dart:convert';
import 'package:location_tracker/models/geofence/polygon.dart';

class GeofenceModel {
  String? name;
  String? purpose;
  List<Polygon>? polygon;
  String? color;

  GeofenceModel({
    this.name,
    this.purpose,
    this.polygon,
    this.color,
  });

  @override
  String toString() {
    return 'CreateGeoFenceModel(name: $name, purpose: $purpose, polygon: $polygon, color: $color)';
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'purpose': purpose,
        'polygon': polygon?.map((e) => e.toMap()).toList(),
        'color': color,
      };

  factory GeofenceModel.fromMap(Map<String, dynamic> data) {
    return GeofenceModel(
      name: data['name'] as String?,
      polygon: (data['polygon'] as List<dynamic>?)
          ?.map((e) => Polygon.fromMap(e as Map<String, dynamic>))
          .toList(),
      purpose: data['purpose'] as String?,
      color: data['color'] != null ? data['color'] as String : null,
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GeofenceModel].
  factory GeofenceModel.fromJson(String data) {
    return GeofenceModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GeofenceModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GeofenceModel copyWith({
    String? name,
    String? purpose,
    List<Polygon>? polygon,
    String? color,
  }) {
    return GeofenceModel(
      name: name ?? this.name,
      purpose: purpose ?? this.purpose,
      polygon: polygon ?? this.polygon,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(covariant GeofenceModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.purpose == purpose &&
        other.color == color;
  }

  @override
  int get hashCode {
    return name.hashCode ^ purpose.hashCode ^ polygon.hashCode ^ color.hashCode;
  }
}
