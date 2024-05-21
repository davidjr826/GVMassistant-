  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';


class ElimuPage extends StatefulWidget{


  const ElimuPage({
    Key? key,

  }) : super(key: key);
  @override

  State<ElimuPage> createState() => _ElimuPageState();
}
  final FirebaseAuth _auth = FirebaseAuth.instance;

class _ElimuPageState extends State<ElimuPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Item 1',
      'Item 2',
      'Item 3',
    ];
    User? user = _auth.currentUser;
    // final pdfController = PdfController(
    //     document: PdfDocument.openAsset('assets/Education_content/comic.pdf'),
    //     initialPage: 2
    // );




    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Elimu')),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [

                Container(
                    child: CarouselSlider(

                      options: CarouselOptions(

                        height: 200.0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,


                        scrollDirection: Axis.horizontal,),
                      items: ['pic1', 'pic2', 'pic3', 'pic4'].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                'assets/icons/${i}.jpg', width: 1000,
                                height: 100,),
                            );
                          },
                        );
                      }).toList(),
                    )
                ),
                const SizedBox(height: 8,),
                Container(
                  padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                          offset: Offset(1.0, 1.0), // shadow direction: bottom right
                        )

                      ],
                    ),
                    child: Text("Karibu, ${user?.email}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Roboto"),)),
              ],
            ),
            const SizedBox(height: 20,),
            const Text("Ukatili wa kijinsia ni nini?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icons/symbol.png', width: 50,
                        height: 45,),
                      const SizedBox(width: 5,),
                      SizedBox(
                        width: 350,

                        child: const Text(
                          '''Ukatili wa kijinsia ni mifano ya vitendo vya kudhalilisha, kutesa, au kuumiza watu kwa sababu ya jinsia yao. ''',
                          style: TextStyle(fontSize: 15,),
                          textAlign: TextAlign.justify,),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      launch("https://tamwa.org/a/images/pdf/comic.pdf");
                    },
                      child:const Center(child: Text("Soma zaidi",style: TextStyle(color: Colors.indigo,fontSize: 15,fontWeight: FontWeight.bold),))
                  ),

                ],
              ),
            ),
            SizedBox(height: 20,),
            Text("GVMAssistant",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.circle,size: 15,),
                      SizedBox(width: 8,),
                      Flexible(child: Text("Ni mfumo wa simu unaokusaidia kupaza sauti kupingana na unyanyasaji wa kijinsia",softWrap: true,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),)),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.circle,size: 15,),
                      SizedBox(width: 8,),
                      Flexible(child: Text("Popote ulipo tutakufikia ongea nasi,tuma ujumbe au bofya kitufe cha dharura au msaada wa haraka",softWrap: true,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),)),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.circle,size: 15,),
                      SizedBox(width: 8,),
                      Flexible(child: Text("Pamoja tunaweza kutokomeza unyanyasaji wa aina yoyote wa kijinsia.",softWrap: true,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),)),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
