import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class MipangilioPage extends StatefulWidget{
  const MipangilioPage({super.key});

  @override
  State<MipangilioPage> createState() => _MipangilioPageState();
}



class _MipangilioPageState extends State<MipangilioPage> {
  @override

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout() async {
    try {
      await _auth.signOut();
      // Navigate to the login page or any other desired page after logout
      // Example: Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Logout error: $e');
    }
  }

  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Mipangilio')),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,

      ),
      body: Column(

        children: [
          SizedBox(height: 10,),
          Container(
            width: 230,
            height: 30,
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


            child: Center(
              child: Text(
                ' ${user?.email}',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
          ),
      SizedBox(height: 30,),



          GestureDetector(
            onTap: ()  {
              void sendPasswordResetEmail(String email) async {
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  // Password reset email sent
                  // You can display a success message to the user
                } catch (e) {
                  // Error occurred while sending the password reset email
                  // You can display an error message to the user
                  print("hello");
                }
              }

              String? email=user?.email;
              sendPasswordResetEmail(email!);
              GoRouter.of(context).go('/Elimu');
              Fluttertoast.showToast(msg: 'Utapokea barua pepe ya kubadili neno la siri');

            },
            child: Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),

                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),

                      child: Icon(Icons.key,size: 30),
                    ),
                    SizedBox(width: 10,),
                    Text("Badili Neno la Siri",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: ()  {
              _logout();
              GoRouter.of(context).go('/Login');
              Fluttertoast.showToast(msg: 'Umefanikiwa kutoka GVMAssistant');

            },
            child: Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),

                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),

                      child: Icon(Icons.person_2_rounded,size: 30),
                    ),
                    SizedBox(width: 10,),
                    Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ) ;
  }
}