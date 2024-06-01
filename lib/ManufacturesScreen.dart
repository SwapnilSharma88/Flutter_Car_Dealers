import 'dart:convert' show json;
import 'dart:io' show File;

import 'package:cardealers/add_new_car.dart';
import 'package:cardealers/car_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

import 'CarDataModel.dart';
String jsondata = 'jsonfile/',
    datajson = jsondata + 'productlist.json';

class ManufacturesScreen extends StatefulWidget {
  const ManufacturesScreen({Key? key}) : super(key: key);

  @override
  State<ManufacturesScreen> createState() => _ManufacturesScreenState();
}

class _ManufacturesScreenState extends State<ManufacturesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: SafeArea(
        child: Scaffold(    
          appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Add_New_Car()));
                },
                icon: Icon(Icons.add, color: Colors.blue,)
            )
          ],
          title: Center(child:  Text("Car Dealers",style: TextStyle(color:  Colors.black,fontSize: 20),),),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0, systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),

          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5,right: 5,bottom: 10),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[400]),
                  child: TabBar(padding: EdgeInsets.all(5),
                    indicator: BoxDecoration(
                     color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelColor: Colors.black,
                    dividerColor: Colors.black,
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: const [
                      Tab(
                          child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Text('All',style:  TextStyle(color:  Colors.black,),),
                          ),
                          Text(' 🚘',style:  TextStyle(color:  Colors.red,),),
                        ],

                      )),
                      Tab(text: 'Petrol🚙',),
                      //     child: Row(children: [
                      //     Padding(
                      //       padding: EdgeInsets.all(0),
                      //       child: Text('Petrol',style:  TextStyle(color:  Colors.black,),),
                      //
                      //     ),
                      //     Text('🚙',style:  TextStyle(color:  Colors.blue,),),
                      //   ],
                      // )),

                      Tab(       text: 'Diesel🚚',),
                      //     child: Row(
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(left: 0),
                      //       child: Text('Diesel',style:  TextStyle(color:  Colors.black,),),
                      //     ),
                      //     Text('🚚',style:  TextStyle(color:  Colors.orange,),),
                      //   ],
                      //
                      // )),

                      Tab(     text:'Electric 🔌',   ),
                      //     child: Row(
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(left: 0),
                      //       child: Text('Electric',style:  TextStyle(color:  Colors.black,),),
                      //     ),
                      //     Text('🔌',style:  TextStyle(color:  Colors.black,),),
                      //   ],
                      //
                      // )),

                    ],
                  ),
                ),),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TabBarView(
                    children: [
                      AllCarsList(),
                      CarsList('Petrol'),
                      CarsList('Diesel'),
                      CarsList('Electric')
                    ],
                  ),
                ),
              ),],
          ),
        ),
      ),
    );
  }

}
class CarsList extends StatelessWidget {
  const CarsList(  this.types, {Key? key}) : super(key: key);
final String types;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:      FutureBuilder(
        future: ReadJsonData(),
        builder: (context,data){
          if(data.hasError){
            return Center(child: Text("${data.error}"));
          }else if(data.hasData){
            var items =data.data as List<CarDataModel>;
            return ListView.builder(
                itemCount:  items.length,
                itemBuilder: (context,index){
                  if(types == items[index].type.toString()){
                  return GestureDetector(
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 70,
                              child: Image(image: NetworkImage(items[index].imageName.toString()),fit: BoxFit.fill,),
                            ),
                            Expanded(child: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].name.toString(),style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),),
                                  Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].locations.toString()),)
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => new Car_Details(items[index].imageName.toString(),
                          items[index].name.toString(),items[index].locations.toString())));
                    },
                    onDoubleTap: (){

                    },

                  );}
                  return Container();

                }
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }

}
class AllCarsList extends StatelessWidget {
  const AllCarsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:

        FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var items = data.data as List<CarDataModel>;

              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 70,
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
                                    Padding(padding: EdgeInsets.only(
                                        left: 8, right: 8),
                                      child: Text(items[index].name.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),),),
                                    Padding(padding: EdgeInsets.only(
                                        left: 8, right: 8),
                                      child: Text(
                                          items[index].locations.toString()),)
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (
                            BuildContext context) =>
                        new Car_Details(items[index].imageName.toString(),
                            items[index].name.toString(),
                            items[index].locations.toString())));
                      },
                      onDoubleTap: () {
                        int id = items[index] as int;
                      //  writJsonData(items);
                        update(id);
                      },
                    );
                  }
              );
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        )
    );
  }
}
Future<List<CarDataModel>>ReadJsonData() async{
  final jsondata = await rootBundle.loadString('assets/productlist.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => CarDataModel.fromJson(e)).toList();
}
update (int id)async{
  try {
    var jsondata = await rootBundle.loadString(
        'assets/productlist.json');
    var list = json.decode(jsondata) as List<dynamic>;

    list[5]['id'] = '1';
    String updatedJsonString = json.encode(jsondata);
    await File('assets/productlist.json').writeAsString(updatedJsonString);

  }catch(e){
    print(e);
  }
//  return list.map((e) => CarDataModel.fromJson(e)).toList();
}
