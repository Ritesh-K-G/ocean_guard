import 'package:cloud_firestore/cloud_firestore.dart';

class QueryModel {
  final String queryID;
  final String user;
  final String description;
  final String place;
  final List<String> images;
  final int urgency;
  final double latitude;
  final double longitude;
  final bool resolved;
  final int date;

  QueryModel({
      required this.queryID,
      required this.user,
      required this.description,
      required this.place,
      required this.images,
      required this.urgency,
      required this.latitude,
      required this.longitude,
      required this.resolved,
      required this.date
      });

  factory QueryModel.fromMap(Map<String, dynamic> map) {
    return QueryModel(
      queryID: map['queryID'] ?? '',
      user: map['user'] ?? '',
      description: map['description'] ?? '',
      place: map['place'] ?? '',
      images: map['images']!=null ? List<String>.from(map['images']) : [],
      urgency: map['urgency'] ?? 0,
      latitude: map['latitude'],
      longitude: map['longitude'],
      resolved: map['resolved'] ?? false,
      date: map['date'] ?? 0,
    );
  }

}
