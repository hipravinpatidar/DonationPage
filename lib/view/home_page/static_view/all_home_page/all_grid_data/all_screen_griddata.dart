import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../api_service/api_service.dart';
import '../../../../../controller/lanaguage_provider.dart';
import '../../../../../model/advertisement_model.dart';
import '../../../../../ui_helper/custom_colors.dart';
import '../static_details/Donationpage.dart';

class AllScreenGridData extends StatefulWidget {

  String purposeId;
  String type;

   AllScreenGridData({super.key,required this.purposeId,required this.type});

  @override
  State<AllScreenGridData> createState() => _AllScreenGridDataState();
}

class _AllScreenGridDataState extends State<AllScreenGridData> {

  bool _isLoading = false;
  int _selectedIndex = 0;

  List<AdvertiseMent> getAds = [];

  Future<void> getAdvertiseMent() async{

    String url = 'https://mahakal.rizrv.in/api/v1/donate/donatetrust';
    Map<String, dynamic> data =
    {
      "type": widget.type,
      "trust_category_id": widget.purposeId,
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

        final getAdvertiseData = AdvertisementModel.fromJson(res);

        setState(() {
          getAds = getAdvertiseData.data;
          print("${getAds.length}");
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

    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.02),
      // itemCount: widget.subcategory.length,
      itemCount: getAds.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: screenWidth<500 ? 0.75 :  screenHeight * 0.9
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

                    Navigator.push(context, MaterialPageRoute(builder: (context) => Donationpage(myId: getAds[index].id),));

                  },
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Container(
                          height: constraints.maxHeight * 0.57,
                          width: constraints.maxWidth * 1,
                          decoration:BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                              image: DecorationImage(image: NetworkImage("${getAds[index].image}"),fit: BoxFit.cover) )
                      ),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: screenWidth * 0.01,),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                child: SizedBox(child: Consumer<LanguageProvider>(builder: (BuildContext context, languageProvider, child) {
                                  return Text("${languageProvider.language == "english" ? getAds[index].enName : getAds[index].hiName}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: screenWidth * 0.040,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 2,);
                                },
                                )
                                )
                            ),

                            SizedBox(height: screenWidth * 0.01,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                                          Text("${languageProvider.language == "english" ?  "Donate Now":  "अभी दान करें"}",textAlign: TextAlign.center,style: TextStyle(fontSize: screenWidth * 0.038,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: const Color.fromRGBO(255, 255, 255, 1)),),
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
      },
    );

  }
}
