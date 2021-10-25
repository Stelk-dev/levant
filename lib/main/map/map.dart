import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapRoute extends StatefulWidget {
  const MapRoute({Key? key}) : super(key: key);

  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  late LocationData _locationData;

  Future getLocation() async => _locationData = await Location().getLocation();

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getLocation(),
          builder: (_, snap) {
            if (snap.connectionState != ConnectionState.done)
              return Center(child: CircularProgressIndicator());
            else
              return GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        _locationData.latitude!, _locationData.longitude!),
                    zoom: 20),
              );
          }),
    );
  }
}
