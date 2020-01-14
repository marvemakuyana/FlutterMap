import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'dart:html';
//import 'dart:ui' as ui;

void main() => runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(28.6921164, 76.8111507);
  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onFlutterMapCreated
      (GoogleMapController controller) {
    _controller.complete(controller);
  }

  final Set<Marker> _markers = {};
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Google Maps'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onFlutterMapCreated,
              markers:_markers,
              onCameraMove: _onCameraMove,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            FloatingActionButton(
              onPressed: _onAddMarkerButtonPressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_location, size: 36.0),
            ),
          ],
        ),
      ),
    );
  }
}
