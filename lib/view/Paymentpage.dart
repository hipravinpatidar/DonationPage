import 'package:flutter/material.dart';

class Paymentpage extends StatefulWidget {

  final int totalAmount;

  final otherAmount;


  const Paymentpage({super.key, required this.totalAmount, this.otherAmount});

  @override
  State<Paymentpage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {

  bool _isHidden = true; // initial state is hidden


  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(220,218,218,1),


      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title:
        Text(
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
        padding:  EdgeInsets.only(top: screenHeight * 0.02,right: screenWidth * 0.03,left: screenWidth * 0.03),
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
                  padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.01),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Image.network('https://media.amway.in/sys-master/images/h21/h97/9023196069918/AkshayaPatra%20Logo_800X800%20px.jpg',width:  screenWidth * 0.2,),
                        
                        SizedBox(width: screenWidth * 0.02,),

                        Text('Help us to Feed Warm Meals And Edu..',style: TextStyle(fontWeight:FontWeight.bold),),

                      ],),

                      Divider(
                        color: Colors.black,
                      ),
                      
                      SizedBox(height: screenHeight * 0.02,),

                      Row(
                        children: [
                           Text('Bill Details:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isHidden = !_isHidden; // toggle the state
                              });
                            },
                            child: Text(_isHidden ? 'SHOW' : 'HIDE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),),
                          ),
                        ],
                      ),

                      _isHidden ? Container(): SizedBox(height: screenHeight * 0.02,),

                      Row(
                        children: [
                          _isHidden ? Container() : Text('Full Name:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          SizedBox(width: screenWidth * 0.3,),
                          _isHidden ? Container() : Text(':', style: TextStyle(fontWeight: FontWeight.bold),),
                          Spacer(),
                          _isHidden ? Container() : Text('mayank', style: TextStyle(fontWeight: FontWeight.bold,),),
                        ],
                      ),

                       _isHidden ? Container() :SizedBox(height: screenHeight * 0.02,),

                      Row(
                        children: [
                          _isHidden ? Container() : Text('Email:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          SizedBox(width: screenWidth * 0.2,),
                          _isHidden ? Container() : Text(':', style: TextStyle(fontWeight: FontWeight.bold),),
                          Spacer(),
                          _isHidden ? Container() : Text('XYZ@gmail.com', style: TextStyle(fontWeight: FontWeight.bold,),),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02,),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange),
                        ),
                        child:Padding(
                          padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.02),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('₹ ${widget.totalAmount  }',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: screenWidth * 0.05),),
                            ],
                          ),
                        ),
                      )



                    ],
                  ),
                ),
              ),

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
                    title: Text('Congratulations'),
                    content: Text(
                      'Your Ticket is successfully Booked',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      // TextButton(
                      //   child: Text('More Tickets Booked'),
                      //   onPressed: () {
                      //     // Navigate to new screen
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => Frontpage()),
                      //     );
                      //   },
                      // ),
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
            backgroundColor: Colors.red,
            elevation: 4,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
