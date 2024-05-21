import 'package:flutter/material.dart';
import 'package:gvmassistant/Screens/ComplaintPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
class TaarifaPage extends StatefulWidget{
  @override
  State<TaarifaPage> createState() => _TaarifaPageState();
}

class _TaarifaPageState extends State<TaarifaPage> {
@override 
 
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Center(child: Text('Taarifa')),
      backgroundColor: Colors.indigo[900],
      foregroundColor: Colors.white,
    ),
    body: Center(
      child: Column(

        children: [
          GestureDetector(
            onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context){
                  return ComplaintForm();
            }
              ));
            },
            child:Container(
              padding: EdgeInsets.all(8),
              width: 360,
              height: 150,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),

              child:Column(
                children: [
                  Image.asset('assets/icons/messageTaarifa.png',width: 80,
                    height: 100,),
                  SizedBox(height: 5,),
                  Text("Tuma Ujumbe",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),

            ),
          ),

          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              FlutterPhoneDirectCaller.callNumber('tel:+255627526088');
            },

            child:Container(
            padding: EdgeInsets.all(8),
            width: 360,
            height: 150,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child:Column(
              children: [
                Image.asset('assets/icons/phone-call.png',height: 80,width: 100,),
                SizedBox(height: 5,),
                Text("Ongea Nasi",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),

          ),
          )

        ],
      ),
    ),

  );

}
}
