import 'package:donation/model/subTrust_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../api_service/api_service.dart';
import '../../../../controller/lanaguage_provider.dart';
import '../../../../model/advertisement_model.dart';
import '../../../../ui_helper/custom_colors.dart';
import '../dynamic_details/Detailspage.dart';
import 'package:html/parser.dart' as html_parser;


class DaanList extends StatefulWidget {

  dynamic myId;
   DaanList({super.key,required this.myId});

  @override
  State<DaanList> createState() => _DaanListState();
}

class _DaanListState extends State<DaanList> {

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
          print("My Name Is ${subTrust[0].enTrustName}");
          print("My Name Is ${subTrust[0].image}");
          print("My length Is ${subTrust.length}");
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
      body: _isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)) :

      ListView.builder(
        //itemCount: widget.subcategory.length,
        itemCount: subTrust.length,
        padding: EdgeInsets.only(left: screenWidth * 0.04,bottom: screenHeight * 0.02,right: screenWidth * 0.04),
        shrinkWrap: true,
        itemBuilder: (context, index) {

          return  Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)

                // boxShadow: const [
                //   BoxShadow(color: CustomColors.clrblack,
                //       spreadRadius: 0.5,
                //       blurRadius: 0.1,
                //       offset: Offset(0, 0.5))
                // ]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03,horizontal: screenWidth * 0.03),
                child: GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(myId: subTrust[index].id,image: subTrust[index].image,),));

                  },
                  child: Row(
                    children: [

                      Container(
                        height: screenHeight * 0.09,
                        width: screenWidth * 0.18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: NetworkImage("${subTrust[index].image}"),fit: BoxFit.cover)
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: screenWidth * 0.6, child: Consumer<LanguageProvider>(builder: (BuildContext context, languageProvider,child) {
                              return Text("${languageProvider.language == "english" ? subTrust[index].enTrustName : subTrust[index].hiTrustName}",style:  TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth * 0.04,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,);
                            },
                            )
                            ),

                            SizedBox(height: screenWidth * 0.02,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.clrorange
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.0001,horizontal: screenWidth * 0.14),
                                child: Consumer<LanguageProvider>(
                                  builder: (BuildContext context, languageProvider, Widget? child) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${languageProvider.language == "english" ? "Donate Now" : "अभी दान करें"}",style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: CustomColors.clrwhite),),

                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                          child: Container(
                                            height: screenHeight * 0.06,
                                            width: screenWidth * 0.06,
                                              child: Image(image: AssetImage("assets/image/heart1.png"),color:Colors.white,)
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },)

      // ListView.builder(
      //   itemCount: subTrust.length,
      //   shrinkWrap: true,
      //   padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03,horizontal: screenWidth * 0.03),
      //   itemBuilder: (context, index) {
      //
      //   // String parsedText = html_parser.parse(subTrust[index].enDescription).body?.text ?? '';
      //
      //     return GestureDetector(
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(myId: subTrust[index].id,),));
      //           },
      //         child: Padding(
      //           padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      //             child: Container(
      //               decoration:  BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   border: Border.all(color: Colors.grey)
      //               ),
      //               child:  Padding(
      //                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.005),
      //                 child: Row(
      //                   children: [
      //
      //                     Container(
      //                       height: screenWidth * 0.15,
      //                       width: screenWidth * 0.15,
      //                       decoration: BoxDecoration(
      //                           shape: BoxShape.circle,
      //                           // borderRadius: BorderRadius.circular(10),
      //                           image: DecorationImage(image: NetworkImage(subTrust[index].image ?? ''),fit: BoxFit.cover)
      //                       ),
      //                     ),
      //
      //                     Padding(
      //                       padding:EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.00),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         children: [
      //
      //                           SizedBox(width: screenWidth * 0.7,child: Text(subTrust[index].enTrustName,style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.w400,color: Colors.black,overflow: TextOverflow.ellipsis,),maxLines: 3)),
      //
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //         )
      //     );
      //   },),
    );
  }
}
