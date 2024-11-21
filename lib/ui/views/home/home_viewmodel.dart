import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  late GoogleMapController _mapController;
  Location _location = Location();


  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 12,
  );

  Set<Marker> markers = {};

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    getUserLocation(); 
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    
    final locationData = await _location.getLocation();

    
    final LatLng userPosition = LatLng(
      locationData.latitude ?? 0.0,
      locationData.longitude ?? 0.0,
    );

    markers.add(
      Marker(
        markerId: MarkerId('current_location'),
        position: userPosition,
        infoWindow: InfoWindow(title: 'You are here'),
      ),
    );

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(userPosition, 14),
    );

    notifyListeners();
  }
}
