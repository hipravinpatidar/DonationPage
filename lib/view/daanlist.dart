import 'package:flutter/material.dart';

import 'Donationpage.dart';
// import 'package:sahityadesign/view/gita_chapter/gita_chapter.dart';


class DaanList extends StatefulWidget {
  const DaanList({super.key});

  @override
  State<DaanList> createState() => _DaanListState();
}

class _DaanListState extends State<DaanList> {



  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03,horizontal: screenWidth * 0.03),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {

                switch(index){

                  // case 0: Navigator.push(context, MaterialPageRoute(builder: (context) => GitaChapter(fontSize: _fontSize,),));

                //   case 1: Navigator.push(context, MaterialPageRoute(builder: (context) => Videomovies(),));
                //
                //   case 2: Navigator.push(context, MaterialPageRoute(builder: (context) => Videobhajan(),));
                //
                //   case 3: Navigator.push(context, MaterialPageRoute(builder: (context) => Videospritual(),));

                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Donationpage(),));
                  },
                  child: Container(
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)
                    ),
                    child:  Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.005),
                      child: Row(
                        children: [

                          Container(
                            height: screenWidth * 0.15,
                            width: screenWidth * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: NetworkImage("https://tse2.mm.bing.net/th?id=OIP.snH3SvZwT2r9SN68Vmz8qQHaHa&pid=Api&P=0&h=180"),fit: BoxFit.cover)
                            ),
                          ),

                          Padding(
                            padding:EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.00),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                 Text("Akancha Srivastava Foundation",style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: Colors.black,overflow: TextOverflow.ellipsis,),maxLines: 1),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },),
    );
  }
}
