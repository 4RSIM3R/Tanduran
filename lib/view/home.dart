import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tanduran/animation/FadeAnimation.dart';
import 'package:tanduran/route/routes.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _image;
  String result;
  bool _busy = false;
  List _recognitions;
  String res;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/tflite/penyakit.tflite",
        labels: "assets/tflite/penyakit.txt",
      );
      print("Datanya :${res.toString()}");
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  void _pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    print("Image Has Been Picked");
    _getPredictionImage(image);
  }

  void _getPredictionImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );
    print("Hasil nya : ${recognitions[0]}");
    var confidence = (recognitions[0]["confidence"] * 100).toStringAsFixed(0);
    print("Confidence nya : $confidence");
    Routes.sailor
        .navigate('/detail', params: {'name': recognitions[0]["label"]});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/home.png"),
                    fit: BoxFit.cover)),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 36.0, horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sobat Petani",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                FadeAnimation(
                    2,
                    InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Color(0xFF02181D),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            "Pilih Gambar",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
