//line 311
import 'package:card_scanner/card_scanner.dart';
import 'package:cardsaver/Utils/colorselector.dart';
import 'package:cardsaver/models/boxes.dart';
import 'package:cardsaver/models/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<StatefulWidget> createState() => CreditCardPageState();
}

class CreditCardPageState extends State<CreditCardPage> {
  late CardDetails _cardDetails;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String bankName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var bankNameController = TextEditingController();
  var selectedColor = Colors.blue.value;
  String? cardType;

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: ExactAssetImage('assets/bg.png'),
            //   fit: BoxFit.fill,
            // ),
            color: Colors.white70,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 12,
                ),
                CreditCardWidget(
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Card Bank',
                  frontCardBorder:
                      !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                  backCardBorder:
                      !useGlassMorphism ? Border.all(color: Colors.grey) : null,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  backgroundImage:
                      useBackgroundImage ? 'assets/card_bg.png' : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  // customCardTypeIcons: <CustomCardTypeIcon>[
                  //   CustomCardTypeIcon(
                  //     cardType: CardType.mastercard,
                  //     cardImage: Image.asset(
                  //       'assets/mastercard.png',
                  //       height: 38,
                  //       width: 38,
                  //     ),
                  //   ),
                  // ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: false,
                          obscureNumber: false,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: Colors.black,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Enter Card Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(fontSize: 14),
                            labelStyle: const TextStyle(fontSize: 14),
                            // focusedBorder: border,
                            // enabledBorder: border,
                            border: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 14),
                            labelStyle: const TextStyle(fontSize: 14),
                            // focusedBorder: border,
                            // enabledBorder: border,
                            border: border,
                            labelText: 'Expiry Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 14),
                            labelStyle: const TextStyle(fontSize: 14),
                            // focusedBorder: border,
                            // enabledBorder: border,
                            border: border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 14),
                            labelStyle: const TextStyle(fontSize: 14),
                            // focusedBorder: border,
                            // enabledBorder: border,
                            border: border,
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, right: 16),
                          child: DropdownButtonFormField(
                              items: <String>[
                                "Credit Card",
                                "Debit Card",
                                "Other"
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                border: border,
                                labelText: (cardType != null ? "Card Type" : "Select Card Type"),
                              ),
                              onChanged: (String? newValue) {setState(() {cardType = newValue!;});}
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, right: 16),
                          child: TextField(
                            controller: bankNameController,
                            decoration: InputDecoration(
                              border: border,
                              labelText: 'Bank/Card Name',
                              labelStyle: const TextStyle(fontSize: 14),
                              // errorText: (bankNameController.toString().isNotEmpty ? "Please input a valid nae" : null),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: ColorSelecting()),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: getColorValue,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF426da0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text(
                              'Save Card',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          // ),
                        ),
                        GestureDetector(
                          onTap: scanCard,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text(
                              'Scan Card',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _onValidate() {
    if (formKey.currentState!.validate()) {
      var data = NotesModal(
        cardnumber: cardNumber,
        expiry: expiryDate,
        cardholder: cardHolderName,
        cvv: cvvCode,
        bankname: bankNameController.text,
        color: selectedColor,
        cardtype: cardType,
      );
      final box = Boxes.getdata();
      box.add(data);
      Navigator.pop(context);
    } else {
    }
  }

  void getColorValue() async {
    var sharedpref = await SharedPreferences.getInstance();
    var sColor = sharedpref.getInt("selectedcolor");
    setState(() {
      if (sColor == null) {
        selectedColor = Colors.lightBlue.value;
      } else {
        selectedColor = sColor;
      }
    });
    _onValidate();
  }

  Future<void> scanCard() async {
    var cardDetails = await CardScanner.scanCard();
    if (!mounted) return;

    _cardDetails = cardDetails!;
    onCreditCardModelChange(CreditCardModel(_cardDetails.cardNumber,
        _cardDetails.expiryDate, _cardDetails.cardHolderName, "", true));
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
