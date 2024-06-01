import 'dart:convert';
import 'dart:io';
import 'package:json_editor_flutter/json_editor_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' as rootBundle ;
import 'package:path_provider/path_provider.dart'; // Import the package

import 'CarDataModel.dart';
// String jsondata = 'C:/Users/swapn/AndroidStudioProjects/cardealers/jsonfile/',
//     datajson = jsondata + 'productlist.json';

class Add_New_Car extends StatefulWidget {
  const Add_New_Car({Key? key}) : super(key: key);

  @override
  State<Add_New_Car> createState() => _Add_New_CarState();
}

class _Add_New_CarState extends State<Add_New_Car> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  List <CarDataModel> cars = [];

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _imageUrlController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () async {
                  String name = _nameController.text;
                  String location = _locationController.text;
                  String imageUrl = _imageUrlController.text;
                  String type = _typeController.text;
                  try {
                    Directory appDocDir = await getApplicationDocumentsDirectory();
                   String appDocPath = appDocDir.path;
                    final File file = File('$appDocPath/productlist.json');

                    CarDataModel newCar =CarDataModel(
                        1,
                        name,
                        type,
                      imageUrl,
                      location,
                      imageUrl
                    );
              cars.add(newCar);
              String updatedData = json.encode(cars.map((car) => car.toJson()).toList());
                  await  file.writeAsString(json.encode(updatedData));
                  print("done");
                                    }
                  catch(e){
                    print(e);
                  }
                  Navigator.pop(context);

                },
                child: Text('save'),            ),

            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
              child: Text('Cancel'),
    )
          ],
          title: Center(child:  Text("Add New Car",style: TextStyle(color:  Colors.black,fontSize: 20),),),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0, systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name',hintText: "BMW, Audi..."),

              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location',hintText:"Penrith, Richmond..." ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Type',hintText: "Petrol,Electric..."),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
