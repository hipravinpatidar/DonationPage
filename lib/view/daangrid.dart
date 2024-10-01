import 'package:flutter/material.dart';

import 'Donationpage.dart';
// import 'package:sahityadesign/view/gita_chapter/gita_chapter.dart';

// import '../../ui_helpers/custom_colors.dart';

class DaanGrid extends StatefulWidget {
  const DaanGrid({super.key});

  @override
  State<DaanGrid> createState() => _GridSahityaState();
}

class _GridSahityaState extends State<DaanGrid>{



  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: GridView.builder(
          padding: EdgeInsets.zero, // Remove the padding around the grid
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0, // Horizontal space between items
            mainAxisSpacing: 0, // Vertical space between items
            childAspectRatio: 1.05,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {

            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,vertical: screenWidth * 0.02),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Donationpage(),));
                    },

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,
                            height: screenHeight * 0.20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  screenHeight * 0.01), // Half of the height
                              child: Stack(
                                fit: StackFit
                                    .expand, // Ensures the stack fills the container
                                children: [
                                  Image.network(
                                    "https://tse2.mm.bing.net/th?id=OIP.snH3SvZwT2r9SN68Vmz8qQHaHa&pid=Api&P=0&h=180",
                                    fit: BoxFit.cover, // Adjusted BoxFit
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 10,
                                    child: Text('Akancha Srivastava\nFoundation',
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));

              },
            );
          },),
      ),
    );
  }
}