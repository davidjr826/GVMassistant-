import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:gvmassistant/Screens/LoginPage.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // String? errorMessage ='';
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

  bool isLogin=true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController InitPasswordcontroller = TextEditingController();
  final TextEditingController Passwordcontroller = TextEditingController();
  final TextEditingController firstnamecontroller = TextEditingController();
  final TextEditingController lastnamecontroller = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> _register() async {

    try {
      final String email = emailcontroller.text.trim();
      final String password = Passwordcontroller.text.trim();

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // User is successfully registered, you can proceed to the next screen or perform any desired action.
      User? user = userCredential.user;
      print('User ID: ${user?.uid}');
    } catch (e) {
      // Handle registration errors, such as invalid email or weak password.
      print('Registration error: $e');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Register')),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),

      body:


      SingleChildScrollView(
        child: Column(
          children: [


            Image.asset('assets/icons/Screenshot (116).png',width: 150,
              height: 150,),

            Form(
              key: _formKey,

              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[

                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      controller: firstnamecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',

                      ),
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      controller: lastnamecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',

                      ),
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',

                      ),
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      controller: phonenumbercontroller,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Namba Ya Simu ',



                      ),

                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty&&value.length==8) {
                          return 'Tafadhali ingiza nywila yenye herufi 8';
                        }
                        return null;
                      },
                      controller: InitPasswordcontroller,
                      maxLength: 8,

                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',

                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 12,),
                    SizedBox(height: 12,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty&&value.length==8) {
                          return 'Tafadhali ingiza nywila yenye herufi 8';;
                        }
                        return null;
                      },
                      controller: Passwordcontroller,
                      maxLength: 8,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Verify Password',

                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),


                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo[900],
                        onPrimary: Colors.white,
                      ),
                      child:  isLoading
                          ? const CircularProgressIndicator() // Display CircularProgressIndicator while loading
                          :const Text('Register'),
                      onPressed: (){

                        void sendDataToFirestore(String? firstname,String lastname,String email,String phonenumber,String password) async {
                          setState(() {
                            isLoading = true;
                          });
                          CollectionReference user = FirebaseFirestore.instance.collection('user');
                          CollectionReference userCollection = FirebaseFirestore.instance.collection('user');
                          QuerySnapshot existingUsers = await userCollection.where('email', isEqualTo: email).limit(1).get();

                          // Create a map or custom data object from your form data
                          Map<String, dynamic> data = {
                            'firstname': firstname,
                            'lastname': lastname,
                            'email':email,
                            'phonenumber':phonenumber,
                            'password':password,


                            // Add more fields as per your form structure
                          };
                          if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                            // All form fields are valid
                            if(existingUsers.docs.isEmpty){
                              try {
                                // Send the data to Firestore
                                await user.add(data);
                                setState(() {
                                  isLoading = false;
                                });

                                // Data successfully added to the database
                                Fluttertoast.showToast(msg: 'Umefanikiwa kujisajili GVMAssistant');
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
                              } catch (e) {
                                // Error occurred while adding data
                                print('Error adding data: $e');
                                Fluttertoast.showToast(msg: 'Tunaomba radhi kwa shida ya mtandao tafadhali jaribu tena');
                              }
                            }
                            else{
                              Fluttertoast.showToast(msg: 'Mtumiaji ${email} tayari amejisajili' );
                            }

                            // Add your Firestore and image upload logic here

                          }



                        }
                        String firstname=firstnamecontroller.text.trim();
                        String lastname=lastnamecontroller.text.trim();
                        String email=emailcontroller.text.trim();
                        String phonenumber=phonenumbercontroller.text.trim();
                        String initpassword=InitPasswordcontroller.text.trim();
                        String password=Passwordcontroller.text.trim();
                        if(initpassword==password){
                          _register();
                          sendDataToFirestore(firstname,lastname,email,phonenumber,password);

                        }
                        else{
                          Fluttertoast.showToast(msg: 'Tafadhali rudia nywila sahihi');

                        }

                      },

                    ),
                  ],

                ),
              ),

            ),
          ],
        ),
      ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}