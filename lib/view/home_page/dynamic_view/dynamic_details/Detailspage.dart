import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:donation/api_service/api_service.dart';
import 'package:donation/controller/lanaguage_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:donation/model/lead_details_model.dart' as LeadDetailsModel;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../model/detailspage_model.dart';
import '../../../../model/success_amount.dart';
import '../../../../ui_helper/custom_colors.dart';

class DetailsPage extends StatefulWidget {
  int myId;
  String? image;


  DetailsPage({super.key, required this.myId, this.image,});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Razorpay _razorpay = Razorpay();
  final TextEditingController _panCardController = TextEditingController();


  String? _displayAmount;
  bool _isLoading = false;

  bool _isExpanded = false;

  final _formKey = GlobalKey<FormState>();

  String _amount = '-------';
  bool _isHidden = true; // initial state is hidden

  String _countryCode = "";

  int _currentIndex = 0;

  bool isCorrected = false;

  bool _isCustomAmount = false;
  bool _isAmountSelected = false;

  int _selectedAmount = 0;

  int _count = 0;
  int _totalAmount = 150;

  Future<void> getSingleDetails() async {
    String url = "https://mahakal.rizrv.in/api/v1/donate/trustget";
    Map<String, dynamic> data = {
      "type": "trust", // ads,trust
      "id": widget.myId
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> res =
          await ApiService().getSingleData(url, data);
      print(res);

      if (res.containsKey('status') &&
          res.containsKey('message') &&
          res.containsKey('data') &&
          res['data'] != null) {
        final detailsPageModel = DetailsModel.fromJson(res);
        setState(() {
          singleDetails = detailsPageModel.data;
        });
      } else {
        print("Error in Single Data: Data field is missing or null");
      }
    } catch (e) {
      print(" Type null is ${e}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Data? singleDetails;

  LeadDetailsModel.Data? leadDetails;

  SuccessAmount? successAmount;

  @override
  void initState() {
    super.initState();
    getSingleDetails();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    print("Success Payment: ${response.paymentId}");

    setState(() {
      _isLoading = true; // Show the progress bar
    });

    await getSuccessDetails();

    setState(() {
      _isLoading = false; // Show the progress bar
    });

    // Show success message to the user
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        message: successAmount!.message,
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error Payment: ${response.code} - ${response.message}");
    // Show error message to the user
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        message: "Payment Failed",
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  Future<void> getSuccessDetails() async {
    String url = "https://mahakal.rizrv.in/api/v1/donate/donateamountsuccess";
    Map<String, dynamic> data =
    {
      "id":"${leadDetails!.id}",
      "amount":_displayAmount,
      "transaction_id":"menu",
      "payment_method":"pay"
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> res = await ApiService().getLeadData(url, data);
      print(res);

      if (res.containsKey('status') &&
          res.containsKey('message') &&
          res.containsKey('data') &&
          res['data'] != null) {
        //final detailsPageModel = LeadDetailsModel.fromJson(res);
        //  final successAmountModel = LeadDetailsModel.LeadDetailsModel.fromJson(res);
        final successAmountModel = SuccessAmount.fromJson(res);
        setState(() {
          successAmount = successAmountModel; // Using nullable data
          print(successAmount!.message);
        });
      } else {
        print("Error in Single trust Data");
      }
    } catch (e) {
      print("Error is ${e}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> getLeadDetails() async {
    String url = "https://mahakal.rizrv.in/api/v1/donate/donateamount";
    Map<String, dynamic> data = {
      "user_id": 3,
      "type": "trust",
      "amount": "500",
      "id": widget.myId,
      "name": "jyoti",
      "phone": "8878769436",
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> res = await ApiService().getLeadData(url, data);
      print(res);

      if (res.containsKey('status') &&
          res.containsKey('message') &&
          res.containsKey('data') &&
          res['data'] != null) {
        //final detailsPageModel = LeadDetailsModel.fromJson(res);
        final leadDetailsModel = LeadDetailsModel.LeadDetailsModel.fromJson(res);
        setState(() {
          leadDetails = leadDetailsModel.data; // Using nullable data
          print(leadDetails!.id);
        });
      } else {
        print("Error in Single Ads Data");
      }
    } catch (e) {
      print("Error is ${e}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> updateDonateAmount() async {
    final url = Uri.parse('https://mahakal.rizrv.in/api/v1/donate/donateamountupdate');
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      "id": leadDetails!.id,
      "amount": _displayAmount,
      "pan_card": _panCardController
    };

    final response = await https.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Donate amount updated successfully!');
    } else {
      print('Failed to update donate amount!');
    }
  }

  void _openPaymentGateway() async {
    var options = {
      'key': 'rzp_test_vsSpBCHRz9XUp2',
      'amount': int.parse(_displayAmount!.replaceAll('₹ ', '')) *
          100, // Convert amount to paise
      'name': 'Donation',
      'description': 'Donation to Mahakal',
      'prefill': {
        'contact': '9123456789',
        'email': 'test@mahakal.com',
      },
      'external': {
        'wallets': ['wallet'],
      }
    };
    Navigator.pop(context);

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(220, 218, 218, 1),

        appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.white,
            title: Consumer<LanguageProvider>(
              builder: (BuildContext context, languageProvider, Widget? child) {
                return Text(
                    "${singleDetails != null ? languageProvider.language == "english" ? singleDetails!.enTrustName : singleDetails!.hiTrustName : ""}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                        fontSize: screenWidth * 0.05,
                        fontFamily: 'Roboto'));
              },
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: screenWidth * 0.06,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),

        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.white,
              ))
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.01),
                child: SingleChildScrollView(
                  child: Consumer<LanguageProvider>(
                    builder: (BuildContext context, languageProvider, Widget? child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200.0,
                              enableInfiniteScroll: true,
                              animateToClosest: true,
                              autoPlay: true,
                              autoPlayAnimationDuration:
                              const Duration(microseconds: 500),
                              // scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            items: [singleDetails!.image[_currentIndex]].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade400,
                                      image: DecorationImage(
                                          image: NetworkImage(i),
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),

                          //
                          // SizedBox(
                          //   height: screenHeight * 0.02,
                          // ),
                          //
                          // Text(languageProvider.language == "english" ? widget.enName : widget.hiName,
                          //   style: TextStyle(
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: screenWidth * 0.04),
                          // ),


                          SizedBox(
                            height: screenHeight * 0.01,
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
                              child: Consumer<LanguageProvider>(
                                builder: (BuildContext context, languageProvider,
                                    Widget? child) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    //  Text('Help us to Feed Warm Meals And Educate Over 400 Underprivileged Children.', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500),),
                                      SizedBox(
                                        height: screenHeight * 0.01,
                                      ),
                                      Text(
                                        "${html_parser.parse(languageProvider.language == "english" ? singleDetails!.enDescription : singleDetails!.hiDescription).body?.text ?? ''}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenWidth * 0.04,
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01,),

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
                              child: Consumer<LanguageProvider>(
                                builder: (BuildContext context, languageProvider, Widget? child) {
                                  return Column(
                                    children: [
                                      // Note 1
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: languageProvider.language == "english" ? '* Note:-'  : "टिप्पणी:",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenWidth * 0.04,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                              languageProvider.language == "english" ?
                                              "1. Avail tz exemption on 50% of the amount you donate under section 80G of the Income Tax Act. Our NGO partners may retain a portion of the donated amount to cover their costs. However, you will receive the 80G certificate for the total amount donated.\n2. Donations once processed cannot be canceled or refunded."
                                                  : "1. आयकर अधिनियम की धारा 80जी के तहत आपके द्वारा दान की गई राशि के 50% पर छूट का लाभ उठाएं। हमारे एनजीओ भागीदार अपनी लागत को कवर करने के लिए दान की गई राशि का एक हिस्सा अपने पास रख सकते हैं। हालाँकि, आपको दान की गई कुल राशि के लिए 80G प्रमाणपत्र प्राप्त होगा।\n2. एक बार  दान होने के बाद इसे रद्द या वापस नहीं किया जा सकता है।",
                                              style: TextStyle(
                                                color: Color.fromRGBO(79, 79, 79, 1),
                                                fontSize: screenWidth * 0.04,
                                              ),
                                            ),
                                          ],
                                        ),
                                        maxLines: _isExpanded ? null : 4,
                                        overflow: _isExpanded
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: screenHeight * 0.01),

                                      // Show more / Show less button
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isExpanded = !_isExpanded;
                                          });
                                        },
                                        child: Text(
                                          _isExpanded ? "Show less" : "Show more",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),

                          // Container(
                          //   width: double.infinity,
                          //   // height: screenHeight * 0.04,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10),
                          //     color: Colors.white,
                          //   ),
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenHeight * 0.01),
                          //     child: Column(
                          //       children: [
                          //         Text.rich(
                          //           TextSpan(
                          //             children: [
                          //              TextSpan(text: '* Note 1 :-', style: TextStyle(color: Colors.black,fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600)),
                          //              TextSpan(text: ' Avail tax exemption on 50% of the amount you donate under Section 80G of the Income Tax Act. Our NGO partners may retain a portion of the donated amount to cover their costs. However, you will receive the 80G certificate for the total amount donated.', style: TextStyle(color: Color.fromRGBO(79,79,79,1), fontSize: screenWidth * 0.04)),
                          //             ],
                          //           ),
                          //         ),
                          //
                          //         SizedBox(height: screenHeight * 0.01,),
                          //
                          //         Text.rich(
                          //           TextSpan(
                          //             children: [
                          //               TextSpan(text: '* Note 2 :-', style: TextStyle(color: Colors.black,fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600)),
                          //               TextSpan(text: ' Avail tax exemption on 50% of the amount you donate under Section 80G of the Income Tax Act. Our NGO partners may retain a portion of the donated amount to cover their costs. However, you will receive the 80G certificate for the total amount donated.', style: TextStyle(color: Color.fromRGBO(79,79,79,1), fontSize: screenWidth * 0.04)),
                          //             ],
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: screenHeight * 0.08,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

        floatingActionButton: _isLoading
            ? Container()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    getLeadDetails();
                    _showBottomSheet(singleDetails!.enTrustName, singleDetails!.hiTrustName);
                  },
                  child: Consumer<LanguageProvider>(
                    builder: (BuildContext context, languageProvider,
                        Widget? child) {
                      return Container(
                        height: screenWidth * 0.14,
                        width: screenWidth * 0.92,
                        decoration: BoxDecoration(
                            color: CustomColors.clrorange,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              languageProvider.language == "english"
                                  ? "Donate Now"
                                  : "अभी दान करें",
                              style: TextStyle(
                                  fontSize: screenWidth * 0.06,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Container(
                                height: screenWidth * 0.06,
                                width: screenWidth * 0.06,
                                child: Image(
                                  image: AssetImage("assets/image/heart1.png"),
                                  color: Colors.white,
                                ))
                          ],
                        )),
                      );
                    },
                  ),
                ),
              ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      ),
    );
  }

  // Function to show a toast message
  void showToast() {
    Fluttertoast.showToast(
      msg: 'Invalid PAN format. Example: ABCDE1234F',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 20,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showBottomSheet(String engname, String hinname) {
    final _razorpay = Razorpay();

    // Reset values before showing the bottom sheet
    _panCardController.clear(); // Clear the PAN card controller
    _amount = ''; // Reset the custom amount
    _displayAmount = '101';

     bool _isWrong = false;

    // Define a variable to store the selected amount
    String _selectedAmount = '101'; // default selected amount

    // Define a list of amounts
    List<String> _amounts = [
      '101',
      '501',
      '551',
      '5001',
    ]; // you can add more amounts to this list

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: CustomColors.clrwhite,
      context: context,
      builder: (BuildContext context) {
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return WillPopScope(
              onWillPop: () async {
                _razorpay
                    .clear(); // Dispose of Razorpay instance when bottom sheet is closed
                return true;
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: 500,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      // color: Color.fromRGBO(220, 218, 218, 1),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.03),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                              vertical: screenHeight * 0.03,
                            ),
                            child: Consumer<LanguageProvider>(
                              builder: (BuildContext context, languageProvider,
                                  Widget? child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      languageProvider.language == "english"
                                          ? 'How much would you like to donate?'
                                          : "आप कितना दान करना चाहेंगे?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: languageProvider.language ==
                                                "english"
                                            ? screenWidth * 0.04
                                            : screenWidth * 0.05,
                                      ),
                                    ),

                                    // Total amount

                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      singleDetails!.image[0]),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: screenWidth * 0.4,
                                                child: Text(
                                                  singleDetails != null
                                                      ? languageProvider
                                                                  .language ==
                                                              "english"
                                                          ? singleDetails!
                                                              .enTrustName
                                                          : singleDetails!
                                                              .hiTrustName
                                                      : "",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  maxLines: 2,
                                                )),
                                            Text("₹${_displayAmount}",style: TextStyle(fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                        Spacer(),
                                        Center(
                                          child: IntrinsicWidth(
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: screenWidth * 0.45),
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: '----',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.orange),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.orange),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.orange),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal:
                                                        screenWidth * 0.04,
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _displayAmount = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: screenHeight * 0.03),

                                        Text(
                                          languageProvider.language == "english"
                                              ? 'Choose other Amount ?'
                                              : "अन्य राशि चुनें ?",
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.04,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          height: 65,
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenWidth * 0.02),
                                          width: double.infinity,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: _amounts.map((amount) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _selectedAmount = amount;
                                                      _displayAmount = amount; // Update display amount when an amount is selected
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(5),
                                                            border: Border.all(
                                                              color:
                                                                  _selectedAmount ==
                                                                          amount
                                                                      ? Colors
                                                                          .orange
                                                                      : Colors
                                                                          .grey,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal:
                                                                  screenWidth *
                                                                      0.05,
                                                              vertical:
                                                                  screenWidth *
                                                                      0.01,
                                                            ),
                                                            child: Text(
                                                              amount,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      screenWidth *
                                                                          0.001,
                                                                  horizontal:
                                                                      screenWidth *
                                                                          0.001),
                                                          child: Text(
                                                            amount == '5001' || amount == '501'
                                                                ? "Most Donated"
                                                                : "", // you can add more conditions here
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        )

                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      // Pan Card here

                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                          ),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomColors.clrorange),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.1,
                                  child: Icon(Icons.credit_card),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Expanded(
                                  child: TextFormField(
                                    controller: _panCardController,
                                    decoration: InputDecoration(
                                      labelText: 'Pan Card (optional)',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value != null && value.isNotEmpty) {
                                        final panRegex =
                                            RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
                                        if (!panRegex.hasMatch(value)) {
                                          showToast();
                                          return null;
                                            //"Invalid PAN format. Example: ABCDE1234F";
                                        } else {
                                          return null;
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenWidth * 0.02),

                      //Total amount here
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
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
                                  // _displayAmount!.isEmpty
                                  //     ? "----"
                                  //     :
                                  "₹${_displayAmount!}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: screenWidth * 0.05),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenWidth * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: Container(
                          width: double.infinity,
                          height: screenWidth * 0.14,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.clrorange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_panCardController.text.isNotEmpty) {
                                  final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
                                  if (!panRegex.hasMatch(_panCardController.text)) {
                                    showToast();
                                    return;
                                  }
                                }
                                _openPaymentGateway();
                                updateDonateAmount();
                              }
                            },
                            child: Consumer<LanguageProvider>(
                              builder: (BuildContext context, languageProvider,
                                  Widget? child) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      languageProvider.language == "english"
                                          ? "Proceed to Pay"
                                          : "भुगतान करें",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.03),
                                    Container(
                                        height: screenWidth * 0.06,
                                        width: screenWidth * 0.06,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/image/heart1.png"),fit: BoxFit.cover,
                                          color: Colors.white,
                                        ))
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
