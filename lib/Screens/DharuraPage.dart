import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DharuraPage extends StatefulWidget{
  @override
  State<DharuraPage> createState() => _DharuraPageState();

}
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? user = _auth.currentUser;
class _DharuraPageState extends State<DharuraPage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // Simulate an asynchronous task
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  var address;
  String? position;
  var phoneNumber;
  String help='Help me';

  Future<void> _updatePosition() async{
    Position pos=await _determinePosition();
    List pm= await placemarkFromCoordinates(pos.latitude, pos.longitude);
    String mapUrl = 'https://www.google.com/maps/search/?api=1&query=${pos.latitude},${pos.longitude}';
    print(mapUrl);
    setState(() async{
      address=mapUrl;

    });



  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future <void> _userPosition() async{
    _updatePosition();
    position= address;

  }


  @override
  Widget build(BuildContext context) {

    Future<String?> getPhoneNumber() async{
      User? user = _auth.currentUser;

      if (user != null) {
        String email = user.email!;

        _firestore
            .collection('user')
            .where('email', isEqualTo: email)
            .get()
            .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            phoneNumber = snapshot.docs.first.get('phonenumber');
            if (phoneNumber != null) {
              print('User Phone Number: $phoneNumber');
              // Use the phoneNumber value as needed
            } else {
              print('User Phone Number not found');
            }
          } else {
            print('User document not found');
          }
        }).catchError((error) {
          print('Error retrieving user document: $error');
        });
      }


    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Dharura')),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200,),
            GestureDetector(
              onLongPress: ()  async{
                setState(() {
                  isLoading = true;
                });
                void sendDataToFirestore(String? position,String email,String phonenumber,String help) async {
                  CollectionReference SOS = FirebaseFirestore.instance.collection('SOS');
                  String eventtime = DateTime.now().toString();

                  // Create a map or custom data object from your form data
                  Map<String, dynamic> data = {
                    'userEmail': email,
                    'location': position,
                    'message':help,
                    'phonenumber':phoneNumber,
                    'EmergencyTime':eventtime,

                    // Add more fields as per your form structure
                  };
                  if (position != null) {
                    // All form fields are valid
                    try {
                      // Send the data to Firestore
                      await SOS.add(data);


                      setState(() {
                        isLoading = false;
                      });
                      // Data successfully added to the database
                      Fluttertoast.showToast(msg: 'Tafadhali Subiri tumepokea ujumbe wako wa dharura');

                    } catch (e) {
                      // Error occurred while adding data
                      print('Error adding data: $e');

                      Fluttertoast.showToast(msg: 'Tunaomba radhi kuna shida ya mtandao tafadhali jaribu tena');
                    }
                    // Add your Firestore and image upload logic here

                  }
                  else{
                    Fluttertoast.showToast(msg: 'Tunaomba radhi kuna shida ya mtandao tafadhali jaribu tena');

                  }



                }
                String? email=user?.email;
                await getPhoneNumber();
                await _userPosition();
                 sendDataToFirestore(position,email!,phoneNumber,help);


              },
              child:Container(
                padding: EdgeInsets.all(8),
                width: 250,
                height: 250,
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
                    Image.asset('assets/icons/urgent.png',width: 100,
                      height: 100,),
                    SizedBox(height: 5,),
                    Text("Msaada Wa Haraka",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Center(child: Text("Bofya kitufe kwa sekunde mbili kupata ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,)),
                    SizedBox(height: 5,),
                    Center(child: Text(" msaada wa dharura",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,)),
                    SizedBox(height: 5,),

                    isLoading
                        ? CircularProgressIndicator() // Display CircularProgressIndicator when isLoading is true
                        : const SizedBox(),
                  ],
                ),

              ),
            ),
          ],
        ),
      ),

    );


  }

}