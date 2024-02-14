import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class showMap extends StatefulWidget {
  const showMap({Key? key}) : super(key: key);

  @override
  State<showMap> createState() => _showMapState();
}

class _showMapState extends State<showMap> {
  late LocationData _currentLocation;
  LatLng source = const LatLng(28.6139, 77.2090);
  late StreamSubscription<LocationData> _locationSubscription;

  final MapController _mapController = MapController();
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _initLocationService();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  void _initLocationService() {
    final location = Location();
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        _locationSubscription = location.onLocationChanged.listen((LocationData result) {
          setState(() {
            _currentLocation = result;
            _updateMap(result);
          });
        });
      }
    });
  }

  void _updateMap(LocationData locationData) {
    _mapController.move(LatLng(locationData.latitude!, locationData.longitude!), 15);
    _markers.clear();
    _markers.add(
      Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(locationData.latitude!, locationData.longitude!),
        child: const Icon(
          Icons.location_on_rounded,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: LatLng(28.6139, 77.2090),
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(markers: [
                  Marker(
                    width: 30.0,
                    height: 30.0,
                    point: source,
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.red,
                    ),
                  ),
                ])
              ],
            ),
          ),
        ],
      );
  }
}