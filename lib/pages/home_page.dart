

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();
  int selectIndex=0;
  List<String> categoriya = [
    "Best Hotels",
    "Luxary Hotels",
    "Cheap Hotels",
    "Five star Hotels "
  ];
  List<String> hotelsImages = [
    "assets/images/ic_hotel0.jpg",
    "assets/images/ic_hotel1.jpg",
    "assets/images/ic_hotel2.jpg",
    "assets/images/ic_hotel3.jpg",
    "assets/images/ic_hotel4.jpg",
  ];
  int time=1;

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5), (){
      setState(() {
        time=0;
      });
    });
  }
  loading() {
    Timer.periodic(Duration(seconds: 6), (timer) {
      selectIndex++;
      if (selectIndex == 5) {
        selectIndex = 0;
      }
      _pageController.animateToPage(selectIndex,
          duration: Duration(milliseconds: 2800), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        loading();
      }, // time==1? Shimmer.fromColors(child:
      child: Scaffold(
          body: SingleChildScrollView(
            child:   Column(
              children: [
                // #shimmer efekti uchun
                time==1? Shimmer.fromColors(child:
                Container(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                    baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade200)
                // #shimmer efectidan keyin shimmerda sosiysi ichida nimadir bulishi kerak
                    :
                Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: MediaQuery.of(context).size.width,
                    child:Stack(children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: hotelsImages.length,
                        itemBuilder: (context, index){
                          return header(hotelsImages[index]);
                        },
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.33,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("What kinf of hotel you \n need?",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 35),),
                            SizedBox(height: 10,),
                            Padding(padding: EdgeInsets.only(left: 20,right: 20),
                              child: TextField(

                                decoration: InputDecoration(filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.search),
                                    hintText: "Search here  looking for",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                                ),
                              ),),
                            SizedBox(height: 20,)

                          ],
                        ),
                      ),
                    ],)

                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child:   time==1? Shimmer.fromColors(child:
                  hotelOfIteams(),
                      baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade200):
                  hotelOfIteams(),
                )
              ],
            ),
          )
      ),
    );
  }

  ListView hotelOfIteams() {
    return ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categoriya.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(padding: EdgeInsets.only(left:15 ),
                              child:  Text(categoriya[index],
                                style: TextStyle(fontSize: 25,color: Colors.black87.withOpacity(0.6),fontWeight: FontWeight.bold),),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: ListView.builder(
                                //shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoriya.length,
                                  itemBuilder: (context, ind) {
                                    return Container(
                                      height: MediaQuery.of(context).size.height * 0.3,
                                      width: 300,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          image: DecorationImage(fit: BoxFit.cover,
                                              image:
                                              AssetImage(hotelsImages[ind]))),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        width: 300,
                                        child: Text("Hotel",style: TextStyle(color: Colors.white,
                                            fontSize: 30),),
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.center,
                                                colors: [
                                                  Colors.black87.withOpacity(0.8),
                                                  Colors.black87.withOpacity(0.4),
                                                  Colors.black87.withOpacity(0.3),
                                                  Colors.black87.withOpacity(0.1),
                                                ]
                                            )
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      );
                    });
  }
  Widget header(String media){
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(media),
          fit: BoxFit.cover,
        )
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black87.withOpacity(0.8),
                  Colors.black87.withOpacity(0.5),
                  Colors.black87.withOpacity(0.4),
                  Colors.black87.withOpacity(0.3),
                ])
        ),
      ),
    );
  }
}
