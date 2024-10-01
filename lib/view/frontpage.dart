import 'dart:html';

import 'package:donation/api_service/api_service.dart';
import 'package:flutter/material.dart';
import '../model/donationcategory_model.dart';
import '../ui_helper/custom_colors.dart';
import 'daangrid.dart';
import 'daanlist.dart';

class Frontpage extends StatefulWidget {
  const Frontpage({super.key});

  @override
  State<Frontpage> createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage>
    with SingleTickerProviderStateMixin {
   // late TabController _tabController;

  bool _isGridView = false;
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
          .getDonationCategory("https://mahakal.in/api/v1/donate/getcategory");
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
        _isLoading = true;
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
          children: [
            Icon(Icons.favorite_border_sharp,
                size: screenWidth * 0.1, color: CustomColors.clrorange),
            SizedBox(
                width: screenHeight * 0.08,
                child:
                    //Center(
                    // child: Consumer<LanguageManager>(
                    // builder: (BuildContext context, languageManager, Widget? child) {
                    // return
                    Text(
                  "All",
                  // languageManager.nameLanguage == 'English' ? "Favourite" : "फेवरेट",
                  style: const TextStyle(
                      fontSize: 13,
                      color: CustomColors.clrblack,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                )
                //   },
                //   ),
                // ),
                ),
          ],
        ),
      ),
      ...donationCategory.map((cat) => Tab(
            height: MediaQuery.of(context).size.width / 6.5,
            child: Column(
              children: [
                Container(
                  height: screenWidth * 0.1,
                  width: screenWidth * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(cat.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenHeight * 0.08,
                  child: Center(
                    child:
                  //  Consumer<LanguageManager>(
                   //   builder: (BuildContext context, languageManager,
                      //    Widget? child) {
                      //  return
                          Text(cat.enName,
                          // cat.hiName,

                        //  languageManager.nameLanguage == 'English' ? cat.enName : cat.hiName,

                          style: const TextStyle(
                              fontSize: 13,
                              color: CustomColors.clrblack,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                        )

                        //},
                   // ),
                  ),
                ),
              ],
            ),
          )),
    ];

    return SafeArea(
      child: DefaultTabController(
          length: donationCategory.length,
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
            ),
            body: Column(
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
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search), // Add a search icon
                            hintText: 'Search...', // Add a search hint
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Add a circular border
                            ),
                            contentPadding:
                                EdgeInsets.all(5), // Add some padding
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.02),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(220, 218, 218, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.01,
                                    vertical: screenWidth * 0.02),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isGridView = true;
                                            });
                                          },
                                          child: Container(
                                            height: screenHeight * 0.04,
                                            width: screenWidth * 0.08,
                                            decoration: BoxDecoration(
                                              color: _isGridView
                                                  ? Colors.white
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: ImageIcon(
                                                AssetImage(
                                                    "assets/image/cube.png"),
                                                color: _isGridView
                                                    ? Colors.orange
                                                    : Colors.black),
                                          )),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isGridView = false;
                                          });
                                        },
                                        child: Container(
                                          height: screenHeight * 0.04,
                                          width: screenWidth * 0.08,
                                          decoration: BoxDecoration(
                                            color: _isGridView
                                                ? null
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ImageIcon(
                                              NetworkImage(
                                                  "https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
                                              color: _isGridView
                                                  ? Colors.black
                                                  : Colors.orange),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                   // controller: _tabController,
                    children: [
                      // SahityaGrid()
                      _isGridView ? DaanGrid() : DaanList(),
                      _isGridView ? DaanGrid() : DaanList(),
                      _isGridView ? DaanGrid() : DaanList(),
                      _isGridView ? DaanGrid() : DaanList(),
                      _isGridView ? DaanGrid() : DaanList(),
                      //
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
