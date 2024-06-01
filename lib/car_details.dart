import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Car_Details extends StatelessWidget {
  const Car_Details( this.image,this.name,this.locations, {Key? key}) : super(key: key);
final String image,name,locations;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (){
                   Navigator.pop(context);
                },
                icon: Icon(Icons.cancel_presentation, color: Colors.blue,)
            )
          ],
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0, systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body:
        Column(children: [
          Container(
            width: double.infinity,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(image: NetworkImage(image),fit: BoxFit.fill,),
            ),
          ),
          Expanded(child: Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(name,style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),),
                Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 10),child: Text("Locations",style: TextStyle(color: Colors.black,fontSize: 18,),),),
                Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 10),child: Text( locations),)

              ],
            ),
          ))
        ],),
      ),
    );
  }
}
