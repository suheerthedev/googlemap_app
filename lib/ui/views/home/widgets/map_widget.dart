import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_app/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        body: GoogleMap(
          onMapCreated: model.onMapCreated,
          initialCameraPosition: model.initialPosition,
          markers: model.markers,
          myLocationEnabled: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: model.getUserLocation,
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}
