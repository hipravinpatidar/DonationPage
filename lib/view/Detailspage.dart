import 'package:flutter/material.dart';

import 'Donationpage.dart';


class Detailspage extends StatefulWidget {
  final int totalAmount;
  const Detailspage({super.key, required this.totalAmount});

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  bool _isHidden = true; // initial state is hidden

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 218, 218, 1),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          "Askhaya Patra Foundation",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.orange,
              fontSize: screenWidth * 0.05,
              fontFamily: 'Roboto'),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,
              color: Colors.black, size: screenWidth * 0.06),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            right: screenWidth * 0.03,
            left: screenWidth * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            'https://media.amway.in/sys-master/images/h21/h97/9023196069918/AkshayaPatra%20Logo_800X800%20px.jpg',
                            width: screenWidth * 0.2,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            'Help us to Feed Warm Meals And Edu..',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      Divider(
                        color: Colors.black,
                      ),

                      SizedBox(
                        height: screenHeight * 0.02,
                      ),

                      // Row(
                      //   children: [
                      //     Text('Bill Details:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      //     Spacer(),
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           _isHidden = !_isHidden; // toggle the state
                      //         });
                      //       },
                      //       child: Text(_isHidden ? 'SHOW' : 'HIDE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),),
                      //     ),
                      //   ],
                      // ),
                      //
                      // _isHidden ? Container(): SizedBox(height: screenHeight * 0.02,),
                      //
                      // Row(
                      //   children: [
                      //     _isHidden ? Container() : Text('Full Name:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      //     SizedBox(width: screenWidth * 0.3,),
                      //     _isHidden ? Container() : Text(':', style: TextStyle(fontWeight: FontWeight.bold),),
                      //     Spacer(),
                      //     _isHidden ? Container() : Text('mayank', style: TextStyle(fontWeight: FontWeight.bold,),),
                      //   ],
                      // ),
                      //
                      // _isHidden ? Container() :SizedBox(height: screenHeight * 0.02,),
                      //
                      // Row(
                      //   children: [
                      //     _isHidden ? Container() : Text('Email:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      //     SizedBox(width: screenWidth * 0.2,),
                      //     _isHidden ? Container() : Text(':', style: TextStyle(fontWeight: FontWeight.bold),),
                      //     Spacer(),
                      //     _isHidden ? Container() : Text('XYZ@gmail.com', style: TextStyle(fontWeight: FontWeight.bold,),),
                      //   ],
                      // ),

                      SizedBox(
                        height: screenHeight * 0.02,
                      ),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenHeight * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹ ${widget.totalAmount}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.05),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                      Text(
                        'This name will affect the 80 G certificate',
                        style:
                            TextStyle(color: Color.fromRGBO(176, 176, 176, 1)),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      Text(
                        'Please enter a valid email on which you want to receive the 80 G certificate',
                        style:
                            TextStyle(color: Color.fromRGBO(176, 176, 176, 1)),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Pan Card',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      Text(
                        '(optional)',
                        style:
                            TextStyle(color: Color.fromRGBO(176, 176, 176, 1)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: double.infinity,
                // height: screenHeight * 0.04,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.01),
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Please Note:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text:
                                    ' This service is available for Indian Nationals only. By proceeding, you confirm your nationality as Indian. Our partners may retain a portion of the donated amount to cover their costs. However, you will receive the receipt for the total amount donated.',
                                style: TextStyle(
                                    color: Color.fromRGBO(79, 79, 79, 1),
                                    fontSize: screenWidth * 0.04)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.08,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenHeight * 0.01,
        ),
        child: Container(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: () {
              // Show a dialog box
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Congratulations....'),
                    content: Text(
                      'Your Donation is Successfully Transfer',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text('Ok'),
                        onPressed: () {
                          // Navigate to new screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Donationpage()),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            label: Text(
              'Proceed to Pay',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Color.fromRGBO(255, 118, 10, 1),
            elevation: 4,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
