import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    _getLocationPermission();
    super.initState();
  }

  void _getLocationPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      // Permission is enabled
    } else {
      // Permission is not enabled
    }

    var status = await Permission.location.status;
    if (status.isGranted) {
      _getLocationData();
    } else if (status.isDenied) {
      // ignore: unused_local_variable
      Map<Permission, PermissionStatus> askPermit = await [
        Permission.location,
      ].request();
    }

    if (await Permission.location.request().isGranted) {
      _getLocationData();
    }

    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _getLocationData() async {
    WeatherModel weatherModel = new WeatherModel();
    var weatherData = await weatherModel.getLocationData();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
