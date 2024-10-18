import 'package:donation/api_service/api_service.dart';
import 'package:donation/controller/lanaguage_provider.dart';
import 'package:donation/ui_helper/custom_colors.dart';
import 'package:donation/view/home_page/in_house_view/in_house_page/inhouse_home.dart';
import 'package:donation/view/home_page/static_view/all_home_page/allscreen_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/donationcategory_model.dart';
import '../dynamic_view/dynamic_grid/daangrid.dart';
import '../dynamic_view/dynamic_list/daanlist.dart';


class Frontpage extends StatefulWidget {
  const Frontpage({super.key});

  @override
  State<Frontpage> createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage>
    with SingleTickerProviderStateMixin {
   // late TabController _tabController;

  bool _isGridView = true;
  bool _isTranslate = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getDonationTabs();
   // _tabController = TabController(length: 5, vsync: this);
  }

  List<DonationTabs> donationCategory = [];

  Future<void> getDonationTabs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> res = await ApiService()
          .getData("https://mahakal.rizrv.in/api/v1/donate/getcategory");
      print(res);

      if (res.containsKey('status') &&
          res.containsKey('message') &&
          res.containsKey('data') &&
          res['data'] != null) {
        final donationTabs = DonationCategoryModel.fromJson(res);

        setState(() {
          donationCategory = donationTabs.data;
          print(donationCategory.length);
        });
      } else {
        print("Error: 'status' or 'data' key is missing or null in response.");
      }
    } catch (e) {
      print("Error donation tabs $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final List<Widget> tabs = [
      Tab(
        height: MediaQuery.of(context).size.width / 6.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Image(image: AssetImage("assets/image/ads.png"),),
            ),
            SizedBox(
                width: screenHeight * 0.06,
                child:
                //   Center(
                // child:
                 Consumer<LanguageProvider>(
                   builder: (BuildContext context, languageProvider, child) {
                  return
                  Text(
                   "${languageProvider.language == "english" ? "Ads" : "विज्ञापन"}",

                  style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      //color: CustomColors.clrblack,
                     // fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                );

              },
               ),
              // ),
            ),
          ],
        ),
      ),

      ...donationCategory.map((cat) =>
          Tab(
            height: MediaQuery.of(context).size.width / 6.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenWidth * 0.1,
                  width: screenWidth * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(cat.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenHeight * 0.08,
                  child:
               //   Center(
                   // child:
                   Consumer<LanguageProvider>(
                     builder: (BuildContext context, languageProvider,
                    Widget? child) {
                        return
                          Text(
                            //cat.enName ?? '',
                          // cat.hiName,

                          "${  languageProvider.language == "english" ? cat.enName : cat.hiName}",
                            //  languageProvider.language == 'english' ? cat.enName : cat.hiName,

                        //  languageManager.nameLanguage == 'English' ? cat.enName : cat.hiName,

                          style: TextStyle(
                              fontSize: screenWidth * 0.04,
                             // color: CustomColors.clrblack,
                             // fontWeight: FontWeight.bold,
                              //overflow: TextOverflow.ellipsis
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        );

                        },
                   ),
                 // ),
                ),
              ],
            ),
          )),

      Tab(
        height: MediaQuery.of(context).size.width / 6.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Image(image: AssetImage("assets/image/house.png"),),
            ),
            SizedBox(
              width: screenHeight * 0.08,
              child:
              //   Center(
              // child:
              Consumer<LanguageProvider>(
                builder: (BuildContext context, languageProvider, child) {
                  return
                    Text(
                      "${languageProvider.language == "english" ? "InHouse" : "घर में"}",

                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        //color: CustomColors.clrblack,
                        // fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    );

                },
              ),
              // ),
            ),
          ],
        ),
      ),

    ];
    final List<Widget> tabViews = [

     _isGridView ? AllScreenHome(isGrid: true,) :  AllScreenHome(isGrid: false,),

      ...donationCategory.map((cat) => _isGridView ? DaanGrid(myId: cat.id,) : DaanList(myId: cat.id,),),

      _isGridView ? InHouseHome(isGrid: true,) :  InHouseHome(isGrid: false,),

      ];

    return SafeArea(
      child: DefaultTabController(
          length: donationCategory.length + 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              title: Text(
                "Donation",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                    fontSize: screenWidth * 0.06,
                    fontFamily: 'Roboto'),
              ),
              centerTitle: true,
              leading: Icon(Icons.arrow_back,
                  color: Colors.black, size: screenWidth * 0.06),

              // actions: [
              //   Padding(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: screenWidth * 0.03,
              //         vertical: screenWidth * 0.02),
              //     child: Row(
              //       children: [
              //         Container(
              //           decoration: BoxDecoration(
              //             color: Color.fromRGBO(220, 218, 218, 1),
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: screenWidth * 0.01,
              //                 vertical: screenWidth * 0.02),
              //             child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   GestureDetector(
              //                       onTap: () {
              //                         setState(() {
              //                           _isGridView = true;
              //                         });
              //                       },
              //                       child: Container(
              //                         height: screenHeight * 0.04,
              //                         width: screenWidth * 0.08,
              //                         decoration: BoxDecoration(
              //                           color: _isGridView
              //                               ? Colors.white
              //                               : null,
              //                           borderRadius:
              //                           BorderRadius.circular(5),
              //                         ),
              //                         child: ImageIcon(
              //                             AssetImage(
              //                                 "assets/image/cube.png"),
              //                             color: _isGridView
              //                                 ? Colors.orange
              //                                 : Colors.black),
              //                       )),
              //                   const SizedBox(
              //                     width: 8,
              //                   ),
              //                   GestureDetector(
              //                     onTap: () {
              //                       setState(() {
              //                         _isGridView = false;
              //                       });
              //                     },
              //                     child: Container(
              //                       height: screenHeight * 0.04,
              //                       width: screenWidth * 0.08,
              //                       decoration: BoxDecoration(
              //                         color: _isGridView
              //                             ? null
              //                             : Colors.white,
              //                         borderRadius:
              //                         BorderRadius.circular(5),
              //                       ),
              //                       child: ImageIcon(
              //                           NetworkImage(
              //                               "https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
              //                           color: _isGridView
              //                               ? Colors.black
              //                               : Colors.orange),
              //                     ),
              //                   ),
              //                 ]),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ],

                actions: [

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                      vertical: screenWidth * 0.02,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                           // color: Color.fromRGBO(220, 218, 218, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              5
                             // horizontal: screenWidth * 0.02,
                            //  vertical: screenWidth * 0.01,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Single button that changes icon and behavior based on _isGridView
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isGridView = !_isGridView;
                                    });
                                  },
                                  child: Container(
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.08,
                                    decoration: BoxDecoration(
                                      color: _isGridView ? Color.fromRGBO(255, 247, 236, 1) : Color.fromRGBO(255, 247, 236, 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ImageIcon(
                                      (_isGridView
                                          ? AssetImage("assets/image/cube.png")
                                          : NetworkImage("https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png")) as ImageProvider<Object>?,
                                      color: _isGridView ? Colors.orange : Colors.black,
                                    ),
                                  ),
                                ),
                                // Language change button

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: screenWidth * 0.02,
                     bottom: screenWidth * 0.02,
                     right: screenWidth * 0.02,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                           // color: Color.fromRGBO(220, 218, 218, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                5
                              // horizontal: screenWidth * 0.02,
                              //  vertical: screenWidth * 0.01,
                            ),
                            child: Consumer<LanguageProvider>(
                              builder: (BuildContext context, languageProvider, Widget? child) {
                                return  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Single button that changes icon and behavior based on _isGridView
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isTranslate = !_isTranslate;
                                          languageProvider.toggleLanguage();
                                        });
                                      },
                                      child: Container(
                                          height: screenHeight * 0.04,
                                          width: screenWidth * 0.08,
                                          decoration: BoxDecoration(
                                            color: _isTranslate ? Color.fromRGBO(255, 247, 236, 1)  : Color.fromRGBO(255, 247, 236, 1),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Icon(_isTranslate ? Icons.translate : Icons.translate,color: _isTranslate ? CustomColors.clrorange : Colors.black,)
                                        // ImageIcon(
                                        //   (_isTranslate
                                        //       ? AssetImage("assets/image/cube.png")
                                        //       : NetworkImage("https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png")) as ImageProvider<Object>?,
                                        //   color: _isTranslate ? Colors.orange : Colors.black,
                                        // ),
                                      ),
                                    ),
                                    // Language change button

                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     // Add language change functionality here
                  //   },
                  //   child: Container(
                  //       height: screenHeight * 0.04,
                  //       width: screenWidth * 0.08,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //       child: Icon(Icons.translate,color: CustomColors.clrorange,)
                  //   ),
                  // ),

                //  SizedBox(width: screenWidth * 0.05)

                ]

            ),
            body:  _isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)) : Column(
              children: [
                TabBar(
                  // controller: _tabController,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
                  splashFactory: NoSplash.splashFactory,
                  physics: AlwaysScrollableScrollPhysics(),
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Colors.orange,
                  indicatorPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  labelStyle: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto'),
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                   tabs: tabs

                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.03, right: screenWidth * 0.0),
                  child: Row(
                    children: [


                      // Expanded(
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       prefixIcon: Icon(Icons.search), // Add a search icon
                      //       hintText: 'Search...', // Add a search hint
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(
                      //             10), // Add a circular border
                      //       ),
                      //       contentPadding:
                      //           EdgeInsets.all(5), // Add some padding
                      //     ),
                      //   ),
                      // ),




                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                   // controller: _tabController,
                    children: tabViews


                  ),
                ),
              ],
            ),
          )),
    );
  }
}
