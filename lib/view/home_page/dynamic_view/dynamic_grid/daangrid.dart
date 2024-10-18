import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:provider/provider.dart';
import '../../../../api_service/api_service.dart';
import '../../../../controller/lanaguage_provider.dart';
import '../../../../model/advertisement_model.dart';
import '../../../../model/subTrust_model.dart';
import '../../../../ui_helper/custom_colors.dart';
import '../dynamic_details/Detailspage.dart';

class DaanGrid extends StatefulWidget {

  dynamic myId;
   DaanGrid({super.key,required this.myId});

  @override
  State<DaanGrid> createState() => _GridSahityaState();
}

class _GridSahityaState extends State<DaanGrid>{

 bool _isLoading = false;

  List<SubTrust> subTrust = [];

  Future<void> getAdvertiseMent() async{

    String url = 'https://mahakal.rizrv.in/api/v1/donate/donatetrust';
    Map<String, dynamic> data = {
      "type": "trust",
      "trust_category_id": widget.myId,
    };

    setState(() {
      _isLoading = true;
    });

    print("My Category Id Is ${widget.myId}");

    try{

      final Map<String, dynamic> res = await ApiService().getAdvertise(url, data);
      print(res);

      if(res.containsKey('status')
          && res.containsKey('message')
          && res.containsKey('data')
          && res['data'] !=null ){

        final getAdvertiseData = SubTrustModel.fromJson(res);

        setState(() {
          subTrust = getAdvertiseData.data;
          print(" Donation Name Is ${subTrust[0].enTrustName}");
        });

      } else {
        print("Error in Advertisement");
      }

    } catch(e){
      print(e);
    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAdvertiseMent();
  }

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body:  _isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)) : Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child:

        GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
          // itemCount: widget.subcategory.length,
          itemCount: subTrust.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: screenWidth<500 ? 0.75:  screenHeight * 0.9
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.02),
              child:  LayoutBuilder(
                builder: (context, constraints) {
                  return  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey)

                      // boxShadow: const [
                      //   BoxShadow(color: CustomColors.clrblack,
                      //       spreadRadius: 0.2,
                      //       blurRadius: 1.5,
                      //       offset: Offset(0, 0.1))
                      // ]
                    ),
                    child: GestureDetector(
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(myId: subTrust[index].id,image: subTrust[index].image,),));

                      },
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Container(
                              height: constraints.maxHeight * 0.57,
                              width: constraints.maxWidth * 1,
                              decoration:BoxDecoration(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                  image: DecorationImage(image: NetworkImage("${subTrust[index].image}"),fit: BoxFit.cover) )
                          ),

                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(height: screenWidth * 0.01,),
                                Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                    child: SizedBox(child: Consumer<LanguageProvider>(builder: (BuildContext context, languageProvider, child) {
                                      return Text("${languageProvider.language == "english" ? subTrust[index].enTrustName : subTrust[index].hiTrustName}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: screenWidth * 0.04,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 2,);
                                    },
                                    )
                                    )
                                ),

                                SizedBox(height: screenWidth * 0.01,),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: CustomColors.clrorange
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03,vertical: screenHeight * 0.01),
                                      child: Consumer<LanguageProvider>(
                                        builder: (BuildContext context, languageProvider,child) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("${languageProvider.language == "english" ?  "Donate Now":  "अभी दान करें"}",textAlign: TextAlign.center,style: TextStyle(fontSize: screenWidth * 0.037,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: const Color.fromRGBO(255, 255, 255, 1)),),
                                              SizedBox(width: screenWidth * 0.03),
                                              Container(
                                                height: screenWidth * 0.06,
                                                width: screenWidth * 0.06,
                                                child: Image(image: AssetImage("assets/image/heart1.png"),color:Colors.white,)
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },)

        // GridView.builder(
        //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,vertical: screenWidth * 0.02), // Remove the padding around the grid
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 0, // Horizontal space between items
        //     mainAxisSpacing: 0, // Vertical space between items
        //     childAspectRatio: 1,
        //   ),
        //   itemCount: subTrust.length,
        //   itemBuilder: (context, index) {
        //
        //     return LayoutBuilder(
        //       builder: (BuildContext context, BoxConstraints constraints) {
        //
        //         // String parsedText =
        //         //     html_parser.parse(getAds[index].enName).body?.text ?? '';
        //
        //         return GestureDetector(
        //           onTap: () {
        //             Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(myId: subTrust[index].id),));
        //           },
        //           child: Padding(
        //             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.02),
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(15),
        //               ),
        //               child: Column(
        //                 children: [
        //                   Container(
        //                       height: screenWidth * 0.43,
        //                       width: 200,
        //                       decoration: BoxDecoration(
        //                         image: DecorationImage(image: NetworkImage(subTrust[index].image ?? ''),fit: BoxFit.cover),
        //                         // borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
        //                         borderRadius: BorderRadius.circular(15),
        //                         // border: Border.all(color: Colors.grey)
        //
        //                       ),
        //
        //                       child: Padding(
        //                         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        //                         child: Align(alignment: Alignment.bottomLeft,child: Text(subTrust[index].enTrustName ?? '',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),maxLines: 2,)),
        //                       )
        //                   ),
        //
        //                   // Container(
        //                   //   height: screenWidth * 0.30,
        //                   //   child: Padding(
        //                   //     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
        //                   //     child: Text(getAds[index].enName ?? '',style: TextStyle(overflow: TextOverflow.ellipsis),maxLines: 5,),
        //                   //   ),
        //                   //   decoration: BoxDecoration(
        //                   //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
        //                   //       border: Border(
        //                   //           right: BorderSide(
        //                   //               color: Colors.grey
        //                   //           ),  left: BorderSide(
        //                   //           color: Colors.grey
        //                   //       ),  bottom: BorderSide(
        //                   //           color: Colors.grey
        //                   //       )
        //                   //       )
        //                   //   ),
        //                   // ),
        //
        //                 ],
        //               ),
        //
        //             ),
        //           ),
        //         );
        //
        //       },
        //     );
        //
        //
        //   },),


      ),
    );
  }
}