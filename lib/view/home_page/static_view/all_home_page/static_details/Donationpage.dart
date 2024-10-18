import 'dart:convert';
import 'package:donation/controller/lanaguage_provider.dart';
import 'package:donation/model/lead_details_model.dart' as LeadDetailsModel;
import 'package:donation/model/success_amount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../../api_service/api_service.dart';
import '../../../../../model/donationdetails_model.dart';
import '../../../../../ui_helper/custom_colors.dart';

class Donationpage extends StatefulWidget {
  int myId;

  Donationpage({super.key, required this.myId});

  @override
  State<Donationpage> createState() => _DonationpageState();
}

class _DonationpageState extends State<Donationpage> {
  final TextEditingController _panCardController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Razorpay _razorpay = Razorpay();

  String _amount = '-------';
  bool _isHidden = true; // initial state is hidden

  bool _isCustomAmount = false;
  bool _isAmountSelected = false;

  int _selectedAmount = 0;

  int _count = 1;
  int _totalAmount = 0;
  bool _isExpanded = false;

  String? _displayAmount;

  bool _isAdded = true;
  bool _isLoading = false;

  Data? donationDetails;
  LeadDetailsModel.Data? leadDetails;

  SuccessAmount? successAmount;

  Future<void> getSuccessDetails() async {
    String url = "https://mahakal.rizrv.in/api/v1/donate/donateamountsuccess";
    Map<String, dynamic> data = {
      "id": "${leadDetails!.id}",
      "amount": _displayAmount,
      "transaction_id": "menu",
      "payment_method": "pay"
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> res =
          await ApiService().getLeadData(url, data);
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

  Future<void> getDonationDetails() async {
    String url = "https://mahakal.rizrv.in/api/v1/donate/trustget";
    Map<String, dynamic> data = {
      "type": "ads", // ads,trust
      "id": "${widget.myId}"
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
        final detailsPageModel = DonationPageModel.fromJson(res);
        setState(() {
          // donationDetails = [detailsPageModel.data]; // Assuming data is a single object, not a list
          donationDetails = detailsPageModel.data;
          print(donationDetails!.enTrustName);

          _displayAmount = donationDetails!.setAmount.toString();
        });
      } else {
        print("Error in Single  Ads Data");
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
      "type": "ads",
      "amount": donationDetails?.setAmount ?? 0,
      "id": widget.myId,
      "name": "jyoti",
      "phone": "8878769436",
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> res =
          await ApiService().getLeadData(url, data);
      print(res);

      if (res.containsKey('status') &&
          res.containsKey('message') &&
          res.containsKey('data') &&
          res['data'] != null) {
        //final detailsPageModel = LeadDetailsModel.fromJson(res);
        final leadDetailsModel =
            LeadDetailsModel.LeadDetailsModel.fromJson(res);
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
    final url =
        Uri.parse('https://mahakal.rizrv.in/api/v1/donate/donateamountupdate');
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

  @override
  void initState() {
    super.initState();
    getDonationDetails();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    _panCardController.dispose(); // Removes all listeners
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
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
                  "${donationDetails != null ? languageProvider.language == "english" ? donationDetails!.enTrustName : donationDetails!.hiTrustName : ""}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.orange,
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Roboto'),
                );
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
                      return  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: screenHeight * 0.25,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                                image: DecorationImage(
                                    image: NetworkImage(donationDetails!.image),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),

                          Text(languageProvider.language == "english" ?  donationDetails!.enName: donationDetails!.hiName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04),
                          ),

                          // Text(data)
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
                                      Text(
                                        "${html_parser.parse(languageProvider.language == "english" ? donationDetails!.enDescription : donationDetails!.hiDescription).body?.text ?? ''}",
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

                          SizedBox(
                            height: screenHeight * 0.01,
                          ),

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
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: screenWidth * 0.02,
                          //         vertical: screenHeight * 0.01),
                          //     child: Column(
                          //       children: [
                          //         Text.rich(
                          //           TextSpan(
                          //             children: [
                          //               TextSpan(
                          //                   text: '* Note 1 :-',
                          //                   style: TextStyle(
                          //                       color: Colors.black,
                          //                       fontSize: screenWidth * 0.04,
                          //                       fontWeight: FontWeight.w600)),
                          //               TextSpan(
                          //                   text:
                          //                       ' Avail tax exemption on 50% of the amount you donate under Section 80G of the Income Tax Act. Our NGO partners may retain a portion of the donated amount to cover their costs. However, you will receive the 80G certificate for the total amount donated.',
                          //                   style: TextStyle(
                          //                       color: Color.fromRGBO(79, 79, 79, 1),
                          //                       fontSize: screenWidth * 0.04)),
                          //             ],
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           height: screenHeight * 0.01,
                          //         ),
                          //         Text.rich(
                          //           TextSpan(
                          //             children: [
                          //               TextSpan(
                          //                   text: '* Note 2 :-',
                          //                   style: TextStyle(
                          //                       color: Colors.black,
                          //                       fontSize: screenWidth * 0.04,
                          //                       fontWeight: FontWeight.w600)),
                          //               TextSpan(
                          //                   text:
                          //                       ' Avail tax exemption on 50% of the amount you donate under Section 80G of the Income Tax Act. Our NGO partners may retain a portion of the donated amount to cover their costs. However, you will receive the 80G certificate for the total amount donated.',
                          //                   style: TextStyle(
                          //                       color: Color.fromRGBO(79, 79, 79, 1),
                          //                       fontSize: screenWidth * 0.04)),
                          //             ],
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          SizedBox(
                            height: screenHeight * 0.08,
                          )
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
                    _showBottomSheet(
                        donationDetails!.setAmount,
                        donationDetails!.setTitle,
                        donationDetails!.enTrustName,
                        donationDetails!.image,
                        donationDetails!.setUnit,
                        donationDetails!.setNumber,
                        donationDetails!.hiTrustName);
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
  showToast() {
    Fluttertoast.showToast(
      msg: "Invalid PAN format. Example: ABCDE1234F",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 20,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showBottomSheet(int amount, String title, String engname, String image,
      String unit, int number, String hinname) {
    final _razorpay = Razorpay();

    // Reset values before showing the bottom sheet
    _panCardController.clear(); // Clear the PAN card controller
    _amount = ''; // Reset the custom amount
    _count = 1; // Reset the count
    _displayAmount = '500'; // Reset the display amount

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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    color: Color.fromRGBO(220, 218, 218, 1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenWidth * 0.04,
                      ),
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

                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(image),
                                                  fit: BoxFit.cover)),
                                        ),

                                        SizedBox(width: screenWidth * 0.02),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: screenWidth * 0.3,
                                                child: Text(
                                                  languageProvider.language ==
                                                          "english"
                                                      ? engname
                                                      : hinname,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  maxLines: 1,
                                                )),
                                            Text(title),
                                            Text(
                                              _count > 1
                                                  ? ' ${_count} x ₹${amount * (_count)}'
                                                  : _count == 0
                                                      ? "₹${_amount}"
                                                      : "₹$amount",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: screenWidth * 0.04,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left: screenWidth * 0.05,
                                              bottom: screenWidth * 0.02),
                                          child: Row(children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.green)),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (_count > 1 ||
                                                          _isCustomAmount) {
                                                        _count = _count > 1 ? _count - 1 : 0;
                                                        _isCustomAmount = false;
                                                        _amount = '';
                                                        _displayAmount =
                                                            '${amount * (_count)}';
                                                      }
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                screenWidth *
                                                                    0.01,
                                                            horizontal:
                                                                screenWidth *
                                                                    0.01),
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 26,
                                                      color:
                                                          CustomColors.clrblack,
                                                    ),
                                                  )),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.02,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.green),
                                                  color: Colors.green),
                                              child: Center(
                                                  child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        screenWidth * 0.02,
                                                    horizontal:
                                                        screenWidth * 0.04),
                                                child: Text(
                                                  "${_count}".toString(),
                                                  style: TextStyle(
                                                      color:
                                                          CustomColors.clrwhite,
                                                      fontSize: 16),
                                                ),
                                              )),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.02,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.green)),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _count++;
                                                      _isAmountSelected = true;
                                                      _isCustomAmount = false;
                                                      _displayAmount =
                                                          '${amount * (_count)}';
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                screenWidth *
                                                                    0.01,
                                                            horizontal:
                                                                screenWidth *
                                                                    0.01),
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 26,
                                                      color:
                                                          CustomColors.clrblack,
                                                    ),
                                                  )),
                                            ),
                                          ]),
                                        ),

                                        // Container(
                                        //   height: screenHeight * 0.06,
                                        //   child: ElevatedButton(
                                        //     style: ElevatedButton.styleFrom(
                                        //       padding: EdgeInsets.zero,
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius: BorderRadius.circular(10),
                                        //         side: BorderSide(
                                        //             width: 1, color: Colors.orange),
                                        //       ),
                                        //       foregroundColor: Colors.white,
                                        //       elevation: 0,
                                        //     ),
                                        //     child: Padding(
                                        //       padding: EdgeInsets.symmetric(
                                        //         horizontal: screenWidth * 0.02,
                                        //       ),
                                        //       child: Row(
                                        //         crossAxisAlignment: CrossAxisAlignment.start,
                                        //         children: [
                                        //           GestureDetector(
                                        //             onTap: () {
                                        //
                                        //               setState(() {
                                        //                 if (_count > 1 || _isCustomAmount) {
                                        //                   _count--;
                                        //                   _isCustomAmount = false;
                                        //                   _amount = '';
                                        //                   _displayAmount = '${amount * (_count)}';
                                        //                 }
                                        //               });
                                        //             },
                                        //             child: Container(
                                        //               height: screenHeight * 0.03,
                                        //               width: screenWidth * 0.09,
                                        //               decoration: BoxDecoration(
                                        //                 border:
                                        //                 Border.all(color: Colors.black),
                                        //                 shape: BoxShape.circle,
                                        //               ),
                                        //               child: Center(
                                        //                 child: Text(
                                        //                   '-',
                                        //                   style:
                                        //                   TextStyle(color: Colors.black),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //           SizedBox(width: screenWidth * 0.02),
                                        //           Text(
                                        //             '$_count',
                                        //             style: TextStyle(
                                        //               color: Colors.black,
                                        //               fontSize: screenWidth * 0.04,
                                        //               fontWeight: FontWeight.bold,
                                        //             ),
                                        //           ),
                                        //           SizedBox(width: screenWidth * 0.02),
                                        //           GestureDetector(
                                        //             onTap: () {
                                        //
                                        //               setState(() {
                                        //                 _count++;
                                        //                 _isAmountSelected = true;
                                        //                 _isCustomAmount = false;
                                        //                 _displayAmount = '${amount * (_count)}';
                                        //               });
                                        //             },
                                        //             child: Container(
                                        //               height: screenHeight * 0.03,
                                        //               width: screenWidth * 0.09,
                                        //               decoration: BoxDecoration(
                                        //                 border:
                                        //                 Border.all(color: Colors.black),
                                        //                 shape: BoxShape.circle,
                                        //               ),
                                        //               child: Center(
                                        //                 child: Text(
                                        //                   '+',
                                        //                   style:
                                        //                   TextStyle(color: Colors.black),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //     onPressed: () {},
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Text(
                                      "Rs ${amount}/ ${number} ${unit}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: CupertinoColors.activeBlue),
                                    ),

                                    SizedBox(height: screenHeight * 0.01),

                                    // Another amount
                                    Row(
                                      children: [
                                        Text(
                                          languageProvider.language == "english"
                                              ? 'Choose other Amount ?'
                                              : "अन्य राशि चुनें ?",
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.04),
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
                                                    borderSide: const BorderSide(
                                                        width: 1,
                                                        color: Colors.orange),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: const BorderSide(
                                                        width: 1,
                                                        color: Colors.orange),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: const BorderSide(
                                                        width: 1,
                                                        color: Colors.orange),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal:
                                                        screenWidth * 0.04,
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _amount = value;
                                                    _isAmountSelected = true;
                                                    _isCustomAmount = true;
                                                    if (_amount.isNotEmpty) {
                                                      _totalAmount =
                                                          int.parse(_amount);
                                                      _displayAmount =
                                                          '$_amount';
                                                    } else {
                                                      _totalAmount = 0;
                                                      _displayAmount = "";
                                                    }
                                                    _count =
                                                        0; // Reset count when custom amount is entered
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.02,
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
                                        final panRegex = RegExp(
                                            r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
                                        if (!panRegex.hasMatch(value)) {
                                          return showToast();
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
                                  _displayAmount!.isEmpty
                                      ? "----"
                                      : "₹${_displayAmount!}",
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      languageProvider.language == "english"
                                          ? "Proceed to Pay"
                                          : "भुगतान करें",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.05,
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
