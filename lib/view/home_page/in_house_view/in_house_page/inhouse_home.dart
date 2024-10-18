import 'package:donation/api_service/api_service.dart';
import 'package:donation/controller/lanaguage_provider.dart';
import 'package:donation/view/home_page/in_house_view/in_house_page/in_house_grid/in_house_griddata.dart';
import 'package:donation/view/home_page/in_house_view/in_house_page/in_house_list/in_house_list.dart';
import 'package:donation/view/home_page/static_view/all_home_page/all_grid_data/all_screen_griddata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/advertisement_model.dart';
import '../../../../model/getpurpose_model.dart';
import '../../../../ui_helper/custom_colors.dart';
import 'package:html/parser.dart' as html_parser;


class InHouseHome extends StatefulWidget {

  bool isGrid;

  InHouseHome({super.key,required this.isGrid});

  @override
  State<InHouseHome> createState() => _InHouseHomeState();
}

class _InHouseHomeState extends State<InHouseHome> {

  bool _isLoading = false;
  int _selectedIndex = 0;


  List<GetPurpose> getPurpose = [];

  List<AdvertiseMent> getAds = [];

  Future<void> getPurposeData() async{

    setState(() {
      _isLoading = true;
    });
    try{
      final Map<String,dynamic> res = await ApiService().getData("https://mahakal.rizrv.in/api/v1/donate/getpurpose");
      print(res);

      if(res.containsKey('status')
          && res.containsKey('message')
          && res.containsKey('data')
          && res['data'] != null ){

        final purposeData = GetPurposeModel.fromJson(res);

        setState(() {
          getPurpose = purposeData.data;
        });
        print(getPurpose.length);

      } else{
        print("error in purpose data");
      }
    } catch(e){
      print(e);
    } finally{
      setState(() {
        _isLoading = false;
      });
    }

  }

  Future<void> getAdvertiseMent() async{

    String url = 'https://mahakal.rizrv.in/api/v1/donate/donatetrust';
    Map<String, dynamic> data =
    {
      "type": "ads",
      "trust_category_id": '',
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
    getPurposeData();
    getAdvertiseMent();
  }
  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    final List<Widget> tabs = [


      Tab(
        height: 30,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _selectedIndex == 0 ? Colors.transparent : Colors.grey,
              )),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenWidth * 0.009),
              child:
              // Consumer<LanguageManager>(
              // builder: (BuildContext context, languageManager, Widget? child) {
              // return
              Consumer<LanguageProvider>(
                builder: (BuildContext context, languageProvider, Widget? child) {
                  return  Row(
                    children: [

                      Image(image: AssetImage("assets/image/all.png")),

                      SizedBox(width: screenWidth * 0.02,),

                      Text("${languageProvider.language == "english" ? "All" : "सभी"}",
                        //  languageManager.nameLanguage == 'English' ? "All" : "सभी",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: CustomColors.clrorange
                        ),
                      ),
                    ],
                  );
                },
              )

            //  },
            //  ),
          ),
        ),
      ),



      ...getPurpose.map((cat) => Tab(
        height: 30,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _selectedIndex == getPurpose.indexOf(cat) + 1 ? Colors.transparent : Colors.grey,
              )),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenWidth * 0.009),
              child:
              // Consumer<LanguageManager>(
              // builder: (BuildContext context, languageManager, Widget? child) {
              // return
              Consumer<LanguageProvider>(
                builder: (BuildContext context, languageProvider, Widget? child) {
                  return  Row(
                    children: [

                      Image(image: NetworkImage(cat.image ?? '')),

                      SizedBox(width: screenWidth * 0.02,),

                      Text("${languageProvider.language == "english" ? cat.enName : cat.hiName}",
                        //  languageManager.nameLanguage == 'English' ? "All" : "सभी",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: CustomColors.clrorange
                        ),
                      ),
                    ],
                  );
                },
              )

            //  },
            //  ),
          ),
        ),
      ),)

    ];

    final List<Widget> tabViews = [

      widget.isGrid ?  InHouseGridData(purposeId: "",type: "ads_inhouse",) : InHouseListData(purposeId: "",type: "ads_inhouse",),

      ...getPurpose.map((cat) =>  widget.isGrid ?  InHouseGridData(purposeId: cat.id.toString(),type: "ads_inhouse",) : InHouseListData(purposeId: cat.id.toString(),type: "ads_inhouse",))

    ];

    return DefaultTabController(
        length: getPurpose.length + 1,
        child:
        _isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,))
            :
        Scaffold(
            backgroundColor: Colors.white,

            appBar: AppBar(
              backgroundColor: Colors.grey.withOpacity(0.1),
              toolbarHeight: 40,
              automaticallyImplyLeading: false,
              flexibleSpace :TabBar(
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index; // Update selected index on tap
                    });
                  },
                  isScrollable: true,
                  padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.01
                  ),
                  unselectedLabelColor: CustomColors.clrblack,
                  labelColor: Colors.black,
                  indicatorWeight: 0.1,
                  splashFactory: NoSplash.splashFactory,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  indicator: BoxDecoration(
                    //  color: Colors.white.withOpacity(0.5),
                      //color: CustomColors.clrorange,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color:  Colors.orange )
                  ),
                  tabs:  tabs
              ),
            ),
            body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: tabViews
            ))
    );
  }
}

