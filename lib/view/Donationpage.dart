

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'frontpage.dart';

class Donationpage extends StatefulWidget {


  const Donationpage({super.key});

  @override
  State<Donationpage> createState() => _DonationpageState();
}

class _DonationpageState extends State<Donationpage> {



  String _amount = '-------';
  bool _isHidden = true; // initial state is hidden


  bool _isCustomAmount = false;
  bool _isAmountSelected = false;


  int _selectedAmount = 0;


  int _count = 0;
  int _totalAmount = 150;

  void _incrementCount() {
    setState(() {
      _count++;
      _totalAmount += 150;
    });
  }

  void _decrementCount() {
    setState(() {
      if (_count > 0) {
        _count--;
        _totalAmount = _totalAmount - 150 > 0 ? _totalAmount - 150 : 0;
      }
    });
  }

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
          "Akshaya Patra Foundation",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.orange,
              fontSize: screenWidth * 0.05,
              fontFamily: 'Roboto'),
        ),
        centerTitle: true,

          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: screenWidth * 0.06,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Frontpage()),
              );
            },
          )
      ),

           body: Padding(
             padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.03,vertical: screenHeight * 0.01),
             child: SingleChildScrollView(
               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

               
                   Container(
                     height: screenHeight * 0.3,
                     width: double.infinity,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.grey),
                     ),
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(10),
                       child: Image.network(
                         "https://thecsruniverse.com/adminxsafe/uploads/Akshaya%20Patra%20Inaugurates.jpg",
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),
                   SizedBox(height: screenHeight * 0.02,),
               
               

                       Text('We are committed to arrange food for Some Physically Unstable Children',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: screenWidth* 0.04),),

                   // Text(data)
                   SizedBox(height: screenHeight * 0.02,),
               
               
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
                           Text('Help us to Feed Warm Meals And Educate Over 400 Underprivileged Children.',style: TextStyle(color: Colors.black,fontSize: screenWidth * 0.04,fontWeight: FontWeight.w500),),
                           
                           SizedBox(height: screenHeight * 0.01,),
                           
                           Text('More than 400 underprivileged kids have found hope thanks to the relentless efforts of Niharika who wishes to give them a better life. She gives them warm meals, helps them with their lessons, and nurtures them with love and care. Support her noble efforts and bring back smiles on hundreds of faces. .',style: TextStyle(color: Color.fromRGBO(79,79,79,1)),)
                         ],
                       ),
                     ),
                   ),

                   SizedBox(height: screenHeight * 0.02,),

               Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: Colors.white,
                 ),
                 child: Padding(
                   padding: EdgeInsets.symmetric(
                     horizontal: screenWidth * 0.02,
                     vertical: screenHeight * 0.01,
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'How much would you like to donate?',
                         style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.w600,
                           fontSize: screenWidth * 0.04,
                         ),
                       ),
                       Row(
                         children: [
                           Text(
                             'Total Amount',
                             style: TextStyle(
                               color: Colors.black,
                               fontSize: screenWidth * 0.04,
                             ),
                           ),
                           SizedBox(width: screenWidth * 0.02),
                           Text(
                             '₹${150 * (_count + 1)}',
                             style: TextStyle(
                               color: Colors.orange,
                               fontSize: screenWidth * 0.06,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Spacer(),
                           Container(
                             height: screenHeight * 0.06,
                             child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 padding: EdgeInsets.zero,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10),
                                   side: BorderSide(width: 1, color: Colors.orange),
                                 ),
                                 foregroundColor: Colors.white,
                                 elevation: 0,
                               ),
                               child: Padding(
                                 padding: EdgeInsets.symmetric(
                                   horizontal: screenWidth * 0.02,
                                 ),
                                 child: Row(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     GestureDetector(
                                       onTap: () {
                                         setState(() {
                                           if (_count > 0) {
                                             _count--;
                                           }
                                         });
                                       },
                                       child: Container(
                                         height: screenHeight * 0.03,
                                         width: screenWidth * 0.09,
                                         decoration: BoxDecoration(
                                           border: Border.all(color: Colors.black),
                                           shape: BoxShape.circle,
                                         ),
                                         child: Center(
                                           child: Text(
                                             '-',
                                             style: TextStyle(color: Colors.black),
                                           ),
                                         ),
                                       ),
                                     ),
                                     SizedBox(width: screenWidth * 0.02),
                                     Text(
                                       '$_count',
                                       style: TextStyle(
                                         color: Colors.black,
                                         fontSize: screenWidth * 0.04,
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                     SizedBox(width: screenWidth * 0.02),
                                     GestureDetector(
                                       onTap: () {
                                         setState(() {
                                           _count++;
                                           _isAmountSelected = true;

                                         });
                                       },
                                       child: Container(
                                         height: screenHeight * 0.03,
                                         width: screenWidth * 0.09,
                                         decoration: BoxDecoration(
                                           border: Border.all(color: Colors.black),
                                           shape: BoxShape.circle,
                                         ),
                                         child: Center(
                                           child: Text(
                                             '+',
                                             style: TextStyle(color: Colors.black),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               onPressed: () {},
                             ),
                           ),
                         ],
                       ),
                       SizedBox(height: screenHeight * 0.02),
                       Container(
                         width: double.infinity,
                         decoration: BoxDecoration(
                           color: Color.fromRGBO(255, 247, 236, 1),
                         ),
                         child: Padding(
                           padding: EdgeInsets.symmetric(
                             horizontal: screenWidth * 0.02,
                             vertical: screenHeight * 0.01,
                           ),
                           child: Column(
                             children: [
                               Center(
                                 child: Text(
                                   '₹150 will sponsor 1 month\'s mid-day meal for 1 child',
                                   style: TextStyle(
                                     color: Color.fromRGBO(255, 118, 10, 1),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                       SizedBox(height: screenHeight * 0.01),
                       Row(
                         children: [
                           Text(
                             'Choose other Amount',
                             style: TextStyle(fontSize: screenWidth * 0.04),
                           ),
                           Spacer(),
                           Center(
                             child: IntrinsicWidth(
                               child: Container(
                                 constraints: BoxConstraints(maxWidth: screenWidth * 0.45),
                                 child: TextField(
                                   textAlign: TextAlign.center,
                                   keyboardType: TextInputType.number,
                                   decoration: InputDecoration(
                                     hintText: '----',
                                     border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(10),
                                       borderSide: BorderSide(width: 1, color: Colors.orange),
                                     ),
                                     focusedBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(10),
                                       borderSide: BorderSide(width: 1, color: Colors.orange),
                                     ),
                                     enabledBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(10),
                                       borderSide: BorderSide(width: 1, color: Colors.orange),
                                     ),
                                     contentPadding: EdgeInsets.symmetric(
                                       horizontal: screenWidth * 0.04,
                                     ),
                                   ),
                                   style: TextStyle(
                                     color: Colors.black,
                                     fontWeight: FontWeight.bold,
                                   ),
                                   onChanged: (value) {
                                     setState(() {
                                       _amount = value;
                                       _isAmountSelected = true;
                                       _isCustomAmount = true;
                                       if (_amount.isNotEmpty) {
                                         _totalAmount = int.parse(_amount);
                                       } else {
                                         _totalAmount = 0;
                                       }
                                       _count = 0; // Reset count when custom amount is entered
                                     });
                                   },
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),

                   SizedBox(height: screenHeight * 0.02,),



                   // _isAmountSelected
                   //     ? Container(
                   //   width: double.infinity,
                   //   decoration: BoxDecoration(
                   //     color: Colors.white,
                   //     borderRadius: BorderRadius.circular(10),
                   //   ),
                   //   child: Padding(
                   //     padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.01),
                   //     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                   //       children: [
                   //         Row(children: [
                   //           Image.network('https://media.amway.in/sys-master/images/h21/h97/9023196069918/AkshayaPatra%20Logo_800X800%20px.jpg',width:  screenWidth * 0.2,),
                   //
                   //           SizedBox(width: screenWidth * 0.02,),
                   //
                   //           Text('Help us to Feed Warm Meals And Edu..',style: TextStyle(fontWeight:FontWeight.bold),),
                   //
                   //         ],
                   //         ),
                   //
                   //         Divider(
                   //           color: Colors.black,
                   //         ),
                   //
                   //
                   //         // ...
                   //
                   //         SizedBox(height: screenHeight * 0.02,),
                   //
                   //         // Container(
                   //         //   width: double.infinity,
                   //         //   decoration: BoxDecoration(
                   //         //     borderRadius: BorderRadius.circular(10),
                   //         //     border: Border.all(color: Colors.orange),
                   //         //   ),
                   //         //   child: Padding(
                   //         //     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.02),
                   //         //     child: Column(
                   //         //       crossAxisAlignment: CrossAxisAlignment.start,
                   //         //       children: [
                   //         //         Text('₹ ${_isCustomAmount ? _amount : (150 * (_count + 1)).toString()}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: screenWidth * 0.05),),
                   //         //       ],
                   //         //     ),
                   //         //   ),
                   //         // ),
                   //
                   //         // SizedBox(height: screenHeight * 0.01,),
                   //
                   //         Container(
                   //           width: double.infinity,
                   //           decoration: BoxDecoration(
                   //             color: Colors.white,
                   //             borderRadius: BorderRadius.circular(10),
                   //           ),
                   //           child: Padding(
                   //             padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.01),
                   //             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                   //               children: [
                   //                 TextField(
                   //                   decoration: InputDecoration(
                   //                     labelText: 'Full Name',
                   //                     border: OutlineInputBorder(
                   //                       borderRadius: BorderRadius.circular(15),
                   //                       borderSide: BorderSide(color: Colors.orange),
                   //
                   //                     ),
                   //
                   //                   ),
                   //                 ),
                   //                 Text('This name will affect the 80 G certificate',style: TextStyle(color: Color.fromRGBO(176, 176, 176, 1)),),
                   //
                   //                 SizedBox(height: screenHeight * 0.02,),
                   //                 TextField(
                   //                   decoration: InputDecoration(
                   //                     labelText: 'Phone Number',
                   //                     border: OutlineInputBorder(
                   //                         borderRadius: BorderRadius.circular(15)
                   //                     ),
                   //                   ),
                   //                 ),
                   //                 Text('Please enter a valid email on which you want to receive the 80 G certificate',style: TextStyle(color: Color.fromRGBO(176, 176, 176, 1)),),
                   //
                   //                 SizedBox(height: screenHeight * 0.02,),
                   //                 TextField(
                   //                   decoration: InputDecoration(
                   //                     labelText: 'Pan Card',
                   //                     border: OutlineInputBorder(
                   //                         borderRadius: BorderRadius.circular(15)
                   //                     ),
                   //                   ),
                   //                 ),
                   //                 Text('(optional)',style: TextStyle(color: Color.fromRGBO(176, 176, 176, 1)),),
                   //
                   //                 SizedBox(height: screenHeight * 0.02,),
                   //
                   //
                   //                 Row(
                   //                   children: [
                   //                     Text('Bill Details:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                   //                     Spacer(),
                   //                     GestureDetector(
                   //                       onTap: () {
                   //                         setState(() {
                   //                           _isHidden = !_isHidden; // toggle the state
                   //                         });
                   //                       },
                   //                       child: Text(_isHidden ? 'SHOW' : 'HIDE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),),
                   //                     ),
                   //                   ],
                   //                 ),
                   //
                   //                 _isHidden ? Container(): SizedBox(height: screenHeight * 0.02,),
                   //
                   //                 Row(
                   //                   children: [
                   //                     _isHidden ? Container() : Text('Full Name:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                   //                     SizedBox(width: screenWidth * 0.3,),
                   //                     _isHidden ? Container() : Text(':', style: TextStyle(fontWeight: FontWeight.bold),),
                   //                     Spacer(),
                   //                     _isHidden ? Container() : Text('mayank', style: TextStyle(fontWeight: FontWeight.bold,),),
                   //                   ],
                   //                 ),
                   //
                   //                 _isHidden ? Container() :SizedBox(height: screenHeight * 0.02,),
                   //
                   //                 Row(
                   //                   children: [
                   //                     _isHidden ? Container() : Text('Email:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                   //                     SizedBox(width: screenWidth * 0.2,),
                   //                     _isHidden ? Container() : Text(':', style: TextStyle(fontWeight: FontWeight.bold),),
                   //                     Spacer(),
                   //                     _isHidden ? Container() : Text('XYZ@gmail.com', style: TextStyle(fontWeight: FontWeight.bold,),),
                   //                   ],
                   //                 ),
                   //
                   //
                   //                 SizedBox(height: screenHeight * 0.02,),
                   //
                   //
                   //
                   //                 Container(
                   //                   width: double.infinity,
                   //                   decoration: BoxDecoration(
                   //                     borderRadius: BorderRadius.circular(10),
                   //                     border: Border.all(color: Colors.orange),
                   //                   ),
                   //                   child: Padding(
                   //                     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.02),
                   //                     child: Column(
                   //                       crossAxisAlignment: CrossAxisAlignment.start,
                   //                       children: [
                   //                         Text('₹ ${_isCustomAmount ? _amount : (150 * (_count + 1)).toString()}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: screenWidth * 0.05),),
                   //                       ],
                   //                     ),
                   //                   ),
                   //                 ),
                   //
                   //
                   //               ],
                   //             ),
                   //           ),
                   //         ),
                   //
                   //       ],
                   //     ),
                   //   ),
                   // )
                   //     : Container(), // hide the container if no amount is selected




                    SizedBox(height: screenHeight * 0.01,),


                   Container(
                     width: double.infinity,
                     // height: screenHeight * 0.04,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white,
                     ),
                     child: Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.01),
                       child: Column(
                         children: [
                           Text.rich(
                             TextSpan(
                               children: [
                                 TextSpan(text: '* Note 1 :-', style: TextStyle(color: Colors.black,fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600)),
                                 TextSpan(text: ' Avail tax exemption on 50% of the amount you donate under Section 80G of the Income Tax Act. Our NGO partners may retain a portion of the donated amount to cover their costs. However, you will receive the 80G certificate for the total amount donated.', style: TextStyle(color: Color.fromRGBO(79,79,79,1), fontSize: screenWidth * 0.04)),
                               ],
                             ),
                           ),

                           SizedBox(height: screenHeight * 0.01,),

                           Text.rich(
                             TextSpan(
                               children: [
                                 TextSpan(text: '* Note 2 :-', style: TextStyle(color: Colors.black,fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600)),
                                 TextSpan(text: ' Avail tax exemption on 50% of the amount you donate under Section 80G of the Income Tax Act. Our NGO partners may retain a portion of the donated amount to cover their costs. However, you will receive the 80G certificate for the total amount donated.', style: TextStyle(color: Color.fromRGBO(79,79,79,1), fontSize: screenWidth * 0.04)),
                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: screenHeight * 0.08,)
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
              _showBottomSheet(context);
              // Show a dialog box
              // showDialog(
              //   context: context,
              //   builder: (context) {
                  // return AlertDialog(
                  //   title: Text('Congratulations....'),
                  //   content: Text(
                  //     'Your Donation is Successfully Transfer',
                  //     style: TextStyle(fontWeight: FontWeight.w500),
                  //   ),
                  //   actions: [
                  //     TextButton(
                  //       child: Text('Cancel'),
                  //       onPressed: () {
                  //         Navigator.of(context).pop(); // Close the dialog
                  //       },
                  //     ),
                  //     TextButton(
                  //       child: Text('Ok'),
                  //       onPressed: () {
                  //         // Navigate to new screen
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => Frontpage()),
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // );
                // },
              // );
            },
            label: Text(
              'Continue',
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
  void _showBottomSheet(BuildContext context) {
    // bool _isHidden = false; // initial state is hidden
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _panCardController = TextEditingController();
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      builder: (context) => Stack(
        children: [
          Container(
            height: 1000, // adjust the height as needed
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                'https://media.amway.in/sys-master/images/h21/h97/9023196069918/AkshayaPatra%20Logo_800X800%20px.jpg',
                                width: screenWidth * 0.2,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                'Provide these details to Contribute',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenWidth * 0.04),
                              ),
                            ],
                          ),
                          Divider(color: Colors.black),
                          SizedBox(height: screenHeight * 0.02),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02,
                                vertical: screenHeight * 0.01,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                            labelText: 'Full Name',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              borderSide: BorderSide(color: Colors.orange),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Name cannot be empty.";
                                            } else if (['abc', 'cba', 'xyz', 'zyx', 'test'].contains(value.toLowerCase())) {
                                              return "This name is not allowed.";
                                            } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                                              return "Only letters are allowed.";
                                            } else if (value.length < 2 || value.trim().isEmpty) {
                                              return "Name should be more than 1 character.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Text(
                                          'This name will affect the 80 G certificate',
                                          style: TextStyle(color: Color.fromRGBO(176, 176, 176, 1)),
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        TextFormField(
                                          controller: _phoneController,
                                          decoration: InputDecoration(
                                            labelText: 'Phone Number',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                          ),
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Phone number cannot be empty.";
                                            } else {
                                              List<String> parts = value.split(' ');
                                              if (parts.length != 2) {
                                                return "Invalid phone number format.";
                                              }
                                              String countryCode = parts[0];
                                              String phone = parts[1];
                                              final phoneRegex = {
                                                '+91': 10, // India
                                                '+1': 10,  // USA
                                                '+44': 10, // UK
                                              };
                                              if (!phoneRegex.containsKey(countryCode)) {
                                                return "Invalid country code.";
                                              } else if (phone.length != phoneRegex[countryCode]) {
                                                return "Phone number should be ${phoneRegex[countryCode]} digits.";
                                              } else {
                                                return null;
                                              }
                                            }
                                          },
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Text(
                                          'Please enter a valid phone number on which you want to receive the 80 G certificate',
                                          style: TextStyle(color: Color.fromRGBO(176, 176, 176, 1)),
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        TextFormField(
                                          controller: _panCardController,
                                          decoration: InputDecoration(
                                            labelText: 'Pan Card',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "PAN card cannot be empty.";
                                            } else {
                                              final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
                                              if (!panRegex.hasMatch(value)) {
                                                return "Invalid PAN format. Example: ABCDE1234F";
                                              } else {
                                                return null;
                                              }
                                            }
                                          },
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Text(
                                          '(optional)',
                                          style: TextStyle(color: Color.fromRGBO(176, 176, 176, 1)),
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        // Center(
                                        //   child: ElevatedButton(
                                        //     onPressed: () {
                                        //       if (_formKey.currentState?.validate() ?? false) {
                                        //         // Process data if form is valid
                                        //         ScaffoldMessenger.of(context).showSnackBar(
                                        //           SnackBar(content: Text('Form submitted successfully')),
                                        //         );
                                        //       }
                                        //     },
                                        //     child: Text('Submit'),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    children: [
                                      Text(
                                        'Bill Details:',
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isHidden = !_isHidden; // toggle the state
                                          });
                                        },
                                        child: Text(
                                          _isHidden ? 'SHOW' : 'HIDE',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                                        ),
                                      ),
                                    ],
                                  ),
                                  _isHidden ? Container() : SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    children: [
                                      _isHidden ? Container() : Text(
                                        'Full Name:',
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: screenWidth * 0.3),
                                      _isHidden ? Container() : Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      _isHidden ? Container() : Text(
                                        'mayank',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  _isHidden ? Container() : SizedBox(height: screenHeight * 0.02),
                                  Row(
                                    children: [
                                      _isHidden ? Container() : Text(
                                        'Email:',
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: screenWidth * 0.2),
                                      _isHidden ? Container() : Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      _isHidden ? Container() : Text(
                                        'XYZ@gmail.com',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.orange),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.02,
                                        vertical: screenHeight * 0.02,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '₹ ${_isCustomAmount ? _amount : (150 * (_count + 1)).toString()}',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: screenWidth * 0.05),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: screenHeight * 0.07,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // SizedBox(height: screenHeight * 0.02,),
          Positioned(
            bottom: 0, // Adjust as needed
            right: 0, // Adjust as needed
            left: 0,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 14),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Background color
                  textStyle: TextStyle(
                    color: Colors.white, // Text color
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Process data if form is valid
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Congratulations...."),
                          content: Text("Your Donation is Successfully Transfer"),
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
                                  MaterialPageRoute(builder: (context) => Frontpage()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Please fill in the form correctly')),
                    // );
                  }
                },
                child: Text(
                  'Proceed to Pay',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

}


