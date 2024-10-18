import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/api_service.dart';
import '../../../../../controller/lanaguage_provider.dart';
import '../../../../../model/advertisement_model.dart';
import '../../../../../ui_helper/custom_colors.dart';
import '../../../static_view/all_home_page/static_details/Donationpage.dart';

class InHouseListData extends StatefulWidget {

  String purposeId;
  String type;

  InHouseListData({super.key,required this.purposeId,required this.type});

  @override
  State<InHouseListData> createState() => _InHouseListDataState();
}

class _InHouseListDataState extends State<InHouseListData> {

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

    return ListView.builder(
      //itemCount: widget.subcategory.length,
      itemCount: getAds.length,
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

            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03,horizontal: screenWidth * 0.03),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Donationpage(myId: getAds[index].id),));
                },
                child: Row(
                  children: [

                    Container(
                      height: screenHeight * 0.09,
                      width: screenWidth * 0.18,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: NetworkImage("${getAds[index].image}"),fit: BoxFit.cover)
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: screenWidth * 0.6, child: Consumer<LanguageProvider>(builder: (BuildContext context, languageProvider,child) {
                            return Text("${languageProvider.language == "english" ? getAds[index].enName : getAds[index].hiName}",style:  TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth * 0.04,color: CustomColors.clrblack,fontFamily: 'Roboto',overflow: TextOverflow.ellipsis),maxLines: 1,);

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
      },);
  }
}
