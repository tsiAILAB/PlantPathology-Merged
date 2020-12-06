import 'package:flutter/material.dart';
import 'package:pds/authentication/login/login_screen.dart';
import 'package:pds/main.dart';
// import 'test.dart';
import 'package:pds/screens/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite/tflite.dart';

import 'live_detection_screen.dart';
import 'model_type_constants.dart';
import 'utils/utils.dart';

class LandingScreenLiveDetec extends StatefulWidget {
  final VoidCallback signOut;

  LandingScreenLiveDetec(this.signOut);

  @override
  _LandingScreenLiveDetecState createState() =>
      _LandingScreenLiveDetecState(this.signOut);
}

class _LandingScreenLiveDetecState extends State<LandingScreenLiveDetec> {
  String _modelName = "";
  // String dropdownValue = 'Four';

  final VoidCallback signOut;

  _LandingScreenLiveDetecState(this.signOut);
  String userRole;

  @override
  void initState() {
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

  void goToObjectDetectionUi(model) {
    setModel(model);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LiveDetectionScreen(cameras, _modelName),
    ));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => HomePage(cameras, plantModel)),
    // );
  }

  setModel(model) {
    setState(() {
      _modelName = model;
    });
    loadModel();
  }

  loadModel() async {
    Tflite.close();
    String res;

    switch (_modelName) {
      case "TOMATO":
        res = await Tflite.loadModel(
          // test model
          model:
              "assets/tflitemodels/object_detection/tomato_ssd_mobilenet_v2_new_final_100.tflite",

          // released model
          // model: "assets/tomato_ssd_mobilenet_v2_new.tflite",

          // previous model
          // model: "assets/tomato_ssd_mobilenet_v2_1.tflite",
          labels:
              "assets/tflitemodels/object_detection/tomato_ssd_mobilenet_v2_1.txt",
        );
        print(
            "TOMATO MODEL LOADED..............................................!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        break;

      case "POTATO":
        res = await Tflite.loadModel(

            // test_models
            // model: "assets/potato_ssd_mobilenet_v2_new.tflite",
            model:
                "assets/tflitemodels/object_detection/potato_ssd_mobilenet_v2_new_final_100.tflite",

            // Released Model
            // model: "assets/potato_ssd_mobilenet_v2_1.tflite",
            labels:
                "assets/tflitemodels/object_detection/potato_ssd_mobilenet_v2.txt");
        print(
            "POTATO MODEL LOADED..............................................!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        break;

      case "MAIZE":
        res = await Tflite.loadModel(

            // test model
            model:
                "assets/tflitemodels/object_detection/maize_ssd_mobilenet_v2_new_final_100.tflite",

            // Released Model
            //   model: "assets/maize_ssd_mobilenet_v2_new.tflite",
            //   previous model
            // model: "assets/maize_ssd_mobilenet_v2_1.tflite",
            labels:
                "assets/tflitemodels/object_detection/maize_ssd_mobilenet_v2_1.txt");
        print(
            "MAIZE MODEL LOADED..............................................!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        break;

      case "GRAPE":
        res = await Tflite.loadModel(

            // test model
            model:
                "assets/tflitemodels/object_detection/grape_ssd_mobilenet_v2_new_final_100.tflite",
            labels: "assets/tflitemodels/object_detection/grape_label.txt");
        print(
            "GRAPE MODEL LOADED..............................................!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        break;
    }
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Detection", style: TextStyle(color: Colors.blueGrey)),
        iconTheme: IconThemeData(color: Colors.blueGrey),
        backgroundColor: Colors.white,
        actions: loadConfigButtonAndLogout(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print("I'm Tomato");
                        goToObjectDetectionUi("TOMATO");
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/tomato.jpg'),
                        radius: 60,
                      ),
                    ),
                    Text(
                      "Tomato",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print("I'm Potato");
                        goToObjectDetectionUi("POTATO");
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/potato.jpg'),
                        radius: 60,
                      ),
                    ),
                    Text(
                      "Potato",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print("I'm Maize");
                        goToObjectDetectionUi("MAIZE");
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/maze.jpg'),
                        radius: 60,
                      ),
                    ),
                    Text(
                      "Maize",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print("I'm Grape");
                        goToObjectDetectionUi("GRAPE");
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/grape.jpg'),
                        radius: 60,
                      ),
                    ),
                    Text(
                      "Grape",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> loadConfigButtonAndLogout() {
    // if (userRole == "ADMIN") {
    var configWidget;

    setState(() {
      configWidget = <Widget>[
        PopupMenuButton<String>(
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return ModelType.modelType.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
        IconButton(
          onPressed: () {
            // if (signOut != null)
            //   signOut();
            // else
            signOutIfEmpty();
          },
          icon: Icon(Icons.power_settings_new),
        ),
      ];
    });
    return configWidget;
    // }
  }

  void choiceAction(String choice) {
    if (choice == ModelType.CModels) {
      print('Classifications');
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen(signOut)),
      );

      // if (signOut != null) {
      //   Navigator.of(context).pop();
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => LandingScreen(this.signOut)),
      //   );
      // } else {
      //   Navigator.of(context).pop();
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             LandingScreen(this.signOutIfEmpty)),
      //   );
      // }
    } else {
      print('Live Detections');
    }
  }

  signOutIfEmpty() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
//      _loginStatus = LoginStatus.notSignIn;
    });
  }
}
