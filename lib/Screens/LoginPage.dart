import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:gvmassistant/Screens/ElimuPage.dart';

import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
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
  // String? errorMessage ='';
  bool isLogin=true;
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // User is successfully logged in, you can proceed to the next screen or perform any desired action.
      User? user = userCredential.user;
      String? useremail=user?.email;
      GoRouter.of(context).go('/Elimu');
      print('email: ${user?.email}');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle login errors, such as incorrect credentials or network issues.
      Fluttertoast.showToast(msg: '${e}');
    };
  }
  // Future<void> signInWithEmailAndPassword() async{
  //   try{
  //     await auth().signInWithEmailAndPassword(
  //       email: controllerEmail.text,
  //       password: controllerPassword.text,
  //     );
  //   } on FirebaseAuthException catch(e){
  //     setState(() {
  //       errorMessage = e.message;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),

      body:


      SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 160,),
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
                        if (value!.isEmpty&&value.length==8) {
                          return 'Tafadhali ingiza taarifa sahihi';
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',

                      ),
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Tafadhali ingiza taarifa sahihi';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      maxLength: 8,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',

                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 12,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo[900],
                        onPrimary: Colors.white,
                      ),

                      onPressed: () async{
                    if (_formKey.currentState != null && _formKey.currentState!.validate()) {

                                        _login();


                    }

                    else{
                      Fluttertoast.showToast(msg: 'Tafadhali jaza taarifa husika');

                    }
                      },
                      child: isLoading
                        ? const CircularProgressIndicator() // Display CircularProgressIndicator while loading
                    : const Text('Login'),


      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo[900],
                        onPrimary: Colors.white,
                      ),
                      child: const Text('Register'),
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterPage()));

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