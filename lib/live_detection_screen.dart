import 'dart:math' as math;

// import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bndbox.dart';
import 'camera.dart';
import 'pretrainded_models_const.dart';
import 'utils/utils.dart';

class LiveDetectionScreen extends StatefulWidget {
  // final List<CameraDescription> cameras;
var cameras;
  final modelName;
  LiveDetectionScreen(this.cameras, this.modelName);

  @override
  _LiveDetectionScreenState createState() => new _LiveDetectionScreenState();
}

class _LiveDetectionScreenState extends State<LiveDetectionScreen> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = ssd;
  String userRole;

  @override
  void initState() {
    super.initState();
    super.initState();
    getPermission();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userRole = preferences.getString("role");
    });
  }

  void getPermission() async {
    await Utils.requestStoragePermission();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      try {
        _recognitions = recognitions;
        _imageHeight = imageHeight;
        _imageWidth = imageWidth;

        if (_recognitions == null) {
          print("RECOGNITION IS NULL!");
        }
      } catch (e) {
        print("ERROR IS IN Recognitions : " + e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modelName + " Diseases Detecting"),
      ),
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          BndBox(
              _recognitions == null ? [] : _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.height,
              screen.width,
              _model),
        ],
      ),
    );
  }
}
