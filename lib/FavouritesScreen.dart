import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'CarDataModel.dart';
class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<CarDataModel> cars = [];
//  List<CarDataModel> items = [];
  // @override
  // void initState() {
  //   super.initState();
  //   ReadJsonData();
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<CarDataModel>;
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    int id = 1;
                      if( id == items[index].id) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: Image(image: NetworkImage(
                                  items[index].imageName.toString()),
                                fit: BoxFit.fill,),
                            ),
                            Expanded(child: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(items[index].name.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),),),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(
                                        items[index].thumbnailName.toString()),)
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                    }
                      else{
                    return Container();}
                  }
              );
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        )
    );
  }

  Future<List<CarDataModel>>ReadJsonData() async{
    final jsondata = await rootBundle.loadString('assets/productlist.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => CarDataModel.fromJson(e)).toList();

    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    // final File file = File('$appDocPath/productlist.json');
    //
    // // If the file doesn't exist, create it and copy data from assets
    // if (!await file.exists()) {
    //   String data = await rootBundle.loadString('assets/productlist.json');
    //   await file.writeAsString(data);
    // }
    //
    // // Read data from the file
    // String jsonData = await file.readAsString();
    // List<dynamic> jsonResult = json.decode(jsonData);
    //
    // // Convert JSON to List<CarDataModel>
    // setState(() {
    //   items = jsonResult.map((json) => CarDataModel.fromJson(json)).toList();
    // });
  }

}
