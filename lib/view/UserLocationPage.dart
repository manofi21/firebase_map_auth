import 'dart:async';
// import 'package:google_maps_webservice/places.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:firebase_map_auth/model/locations.dart';
import 'package:firebase_map_auth/view/widget/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:new_firebase/model/locations.dart';
// import 'package:new_firebase/view/widget/input_widget.dart';

// class UserLocationPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     UserLocationWidget wrap = UserLocationWidget();
//     return Scaffold(
//       body: Center(
//         child: Container(
//           child: wrap.buttonSingOut(context),
//         ),
//       ),
//     );
//   }
// }

class UserLocationPage extends StatefulWidget {
  final LocationModel _locationModel;
  UserLocationPage(this._locationModel);
  @override
  _UserLocationPageState createState() =>
      _UserLocationPageState(_locationModel);
}

class _UserLocationPageState extends State<UserLocationPage> {
  final LocationModel _locationModel;
  _UserLocationPageState(this._locationModel);

  // Map<PolylineId, Polyline> _mapPolylines = {};
  // int _polylineIdCounter = 1;
  final Set<Marker> _markers = {};
  GoogleMapController _controller;
  // List<LatLng> routeCoords;

  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyBpK42KpQEDxvAR571Vi5NS076WVBeQbbQ");

  // @override
  // void initState() {
  //   super.initState();
  //   final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
  //   _polylineIdCounter++;
  //   final PolylineId polylineId = PolylineId(polylineIdVal);

  //   final Polyline polyline = Polyline(
  //     polylineId: polylineId,
  //     consumeTapEvents: true,
  //     color: Colors.red,
  //     width: 5,
  //     points: _createPoints(),
  //   );

  //   // _controller.animateCamera(
  //   //   CameraUpdate.newCameraPosition(
  //   //     CameraPosition(
  //   //       target: LatLng(_locationModel.lat, _locationModel.long),
  //   //       zoom: 18.0,
  //   //     ),
  //   //   ),
  //   // );

  //   setState(() {
  //     _mapPolylines[polylineId] = polyline;
  //   });
  // }

  // List<LatLng> _createPoints() {
  //   final List<LatLng> points = <LatLng>[];
  //   points.add(LatLng(_locationModel.lat, _locationModel.long));
  //   points.add(LatLng(-6.4095594, 106.868087));
  //   return points;
  // }

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    // points.add(LatLng(1.875249, 0.845140));
    // points.add(LatLng(4.851221, 1.715736));
    // points.add(LatLng(8.196142, 2.094979));
    // points.add(LatLng(12.196142, 3.094979));

    points.add(LatLng(_locationModel.lat, _locationModel.long));
    points.add(LatLng(-6.3825791, 106.8298745));
    return points;
  }

  // @override
  // Widget build(BuildContext context) {
  //   LatLng _initialPoint = LatLng(_locationModel.lat, _locationModel.long);
  //   final CameraPosition _initialPosition =
  //       CameraPosition(target: _initialPoint, zoom: 40);
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Maps"),
  //       // actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: _add)],
  //     ),
  //     body:
  //     GoogleMap(
  //       initialCameraPosition: _initialPosition,
  //       // const CameraPosition(target: LatLng(0, 0), zoom: 4.0),
  //       polylines: Set<Polyline>.of(_mapPolylines.values),
  //     ),
  //   );
  // }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng _initialPoint = LatLng(_locationModel.lat, _locationModel.long);
    final CameraPosition _initialPosition =
        CameraPosition(target: _initialPoint, zoom: 8.0);
    _markers.add(Marker(
        markerId: MarkerId("${_locationModel.lat}, ${_locationModel.long}"),
        position: _initialPoint,
        icon: BitmapDescriptor.defaultMarker));

    UserLocationWidget wrap = UserLocationWidget();
    return Scaffold(
        appBar: AppBar(actions: [wrap.buttonSingOut(context)]),
        //   body: GoogleMap(
        //   initialCameraPosition:  _initialPosition,
        //       // const CameraPosition(target: LatLng(0, 0), zoom: 4.0),
        //   polylines: Set<Polyline>.of(_mapPolylines.values),
        // ),
        body: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          onMapCreated: onMapCreated,
          // polylines: Set<Polyline>.of(_mapPolylines.values),
          markers: _markers,
          onTap: (coordinate) {
            _controller.animateCamera(CameraUpdate.newLatLng(coordinate));
          },
        ));
  }
}
