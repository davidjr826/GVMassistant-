// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:file/file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uri_to_file/uri_to_file.dart';



String? selectViolance;
String? selectGender;
String? gender;
final victimFname = TextEditingController();
final victimLname = TextEditingController();
final victimPnumber = TextEditingController();
final victimDescr = TextEditingController();
final _formKey = GlobalKey<FormState>();
final FirebaseAuth _auth = FirebaseAuth.instance;
class ComplaintForm extends StatefulWidget{
  const ComplaintForm({super.key});

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();

}

class _ComplaintFormState extends State<ComplaintForm> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // Simulate an asynchronous task
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  final List<String> _violance = ['Kimwili', 'Kingono', 'Kisaikolojia', 'Kiuchumi'];
  final List<String> _gender = ['Me','Ke'];
  String? _selectedViolance;
  String? _selectedGender;
  String? selectedImagePath;
  String? imageUrl;
  User? user = _auth.currentUser;


  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(child: Text('Ujumbe')),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body:SingleChildScrollView(
        child:Form(
          key: _formKey,

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:[

              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tafadhali tupatie taarifa husika';
                  }
                  return null;
                },
                controller: victimFname,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Jina la kwanza',


                ),
              ),

              const SizedBox(height: 12,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tafadhali tupatie taarifa husika';
                  }
                  return null;
                },
                controller: victimLname,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Jina la Ukoo',


                ),
              ),
              const SizedBox(height: 8,),

              Container(

                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                    border: Border.all( width: 0.7)),
                child: DropdownButton(
                  isExpanded: true,
                  underline: Container(),

                  alignment: Alignment.centerLeft,
                  hint: const Text('Tafadhali chagua aina ya ukatili.'), // Not necessary for Option 1
                  value: _selectedViolance,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedViolance = newValue;
                    });
                  },
                  items: _violance.map((violance) {
                    return DropdownMenuItem(
                      onTap: (){
                         selectViolance=violance;
                        print(selectViolance);
                      },
                      value: violance,
                      child: Text(violance),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 5,),
              Container(

                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                    border: Border.all( width: 0.7)),
                child: DropdownButton(
                  isExpanded: true,
                  underline: Container(),

                  alignment: Alignment.centerLeft,
                  hint: const Text('Tafadhali tambulisha  jinsia yako.'), // Not necessary for Option 1
                  value: _selectedGender,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  items: _gender.map((violance) {
                    return DropdownMenuItem(
                      onTap: (){
                        selectGender=violance;
                        print(selectGender);
                      },
                      value: violance,
                      child: Text(violance),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 5,),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tafadhali tupatie taarifa husika';
                  }
                  return null;
                },
                controller: victimPnumber,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Namba Ya Simu ',



                ),

              ),
              const SizedBox(height: 5,),
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text('Nini Kimetokea',style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                    border: Border.all( width: 0.7)),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tafadhali tupatie taarifa husika';
                    }
                    return null;
                  },
                  controller: victimDescr,

                  minLines: 6, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,

                  maxLines: null,


                ),
              ),
              const SizedBox(height: 5,),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.indigo[900],
                  ),
                  onPressed: () async{

                    Future<File?> getImage() async {
                      final picker = ImagePicker();
                      final pickedFile = await picker.pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        setState(() {
                          selectedImagePath = pickedFile.path;
                          print("${selectedImagePath}");
                          print("hello");
                        });
                      }
                      return null;
                    }


                    getImage();




                  },
                  child: const Text('Pakia Picha'),

                ),

              ),


              const SizedBox(height: 5,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.indigo[900],
                  ),
                  onPressed: ()async{
                    setState(() {
                      isLoading = true;
                    });
                    String? userID=user?.uid;
                    Future<String?> uploadImageToFirebaseStorage() async {
                      String fileName = basename(selectedImagePath!);
                      print("${fileName}");
                      var file = await toFile(selectedImagePath!);
                      Reference storageReference = FirebaseStorage.instance.ref().child('images/');
                      print('${fileName}');
                      final uploadTask = storageReference
                          .child('${DateTime.now()}.jpg')
                          .putFile(file);
                      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);


                      // Get the image download URL
                      imageUrl = await taskSnapshot.ref.getDownloadURL();
                      Fluttertoast.showToast(msg: 'Hongera tumepokea picha ya tukio ${fileName}');

                      return imageUrl;




                    }

                      void sendDataToFirestore(String firstname,String lastname,String violance_category,String gender,String phone_number,String description,String imageUrl) async {

                          String eventtime = DateTime.now().toString();
                        CollectionReference complain = FirebaseFirestore.instance.collection('complain');

                        // Create a map or custom data object from your form data
                        Map<String, dynamic> data = {
                          'firstname': firstname,
                          'lastname': lastname,
                          'violance_category':violance_category,
                          'gender':gender,
                          'phone_number':phone_number,
                          'description':description,
                          'evidence': imageUrl,
                          'userID':userID,
                          'eventtime':eventtime,

                          // Add more fields as per your form structure
                        };
                        if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                          // All form fields are valid
                          try {
                            // Send the data to Firestore
                            await complain.add(data);
                            setState(() {
                              isLoading = false;
                            });
                            GoRouter.of(context).go('/Elimu');


                            // Data successfully added to the database

                            Fluttertoast.showToast(msg: 'Tafadhali Subiri tumepokea ujumbe wako');


                          } catch (e) {
                            // Error occurred while adding data
                            print('Error adding data: $e');

                            Fluttertoast.showToast(msg: 'Tafadhali Jaribu tena kuna shida ya mtandao');
                          }
                          // Add your Firestore and image upload logic here

                        }
                        else{
                          Fluttertoast.showToast(msg: 'Tafadhali jaza taarifa husika');


                        }

                        // Send the data to Firestore

                      }
                      String firstname=victimFname.text.trim();
                      String lastname=victimLname.text.trim();
                      String violance_category=_selectedViolance.toString().trim();
                      String gender=_selectedGender.toString().trim();
                      String phone_number=victimPnumber.text.trim();
                      String description=victimDescr.text.trim();
                      uploadImageToFirebaseStorage();
                      sendDataToFirestore(firstname,lastname,violance_category,gender,phone_number,description,imageUrl!);




                  },
                  child: isLoading
                      ? const CircularProgressIndicator() // Display CircularProgressIndicator while loading
                      :const Text('Tuma'),

                ),
              ),

            ],

          ),
        ),

      ),
      ),
    );
  }
}