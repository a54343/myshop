import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soping/src/controller/bank/BankController.dart';

import '../../styles/colors_app.dart';
import '../../util/http/Userapi_util.dart';
import '../../util/localization/loadToken.dart';

class PayCard extends StatefulWidget {
  const PayCard({Key? key}) : super(key: key);
  @override
  State<PayCard> createState() => _PayCardState();
}

class _PayCardState extends State<PayCard> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;
  late FocusNode _focusNode;
  final cardNumberCtrl = TextEditingController();
  final expiryFieldCtrl = TextEditingController();
  final cardhodlCtrl = TextEditingController();
  final cvvCtrl = TextEditingController();
  final BankController bankController = Get.put(BankController());

  @override
  void initState() {
    super.initState();
    _initializeState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  _initializeState() async {
    String? token = await ReadToken();
    final Map<String, dynamic> data = await getcard(token!);
    print(data);
    cardNumberCtrl.text = data['cardnum'] ?? '';
    expiryFieldCtrl.text = data['expdate'] ?? '';
    cardhodlCtrl.text = data['holdname'] ?? '';
    cvvCtrl.text = data['cvv'] ?? '';
    setState(() {
      cardNumber = cardNumberCtrl.text;
      expiryDate = expiryFieldCtrl.text;
      cardHolderName = cardhodlCtrl.text;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor:
                isLight ? ColorsApp.neutral100 : ColorsApp.slate900,
            snap: true,
            floating: true,
            elevation: 1,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ElasticIn(
                      duration: const Duration(milliseconds: 1500),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: SvgPicture.asset(
                          "assets/icons/arrow_alt_left.svg",
                          height: 16,
                          color:
                              isLight ? ColorsApp.slate900 : ColorsApp.slate100,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElasticIn(
                      duration: const Duration(milliseconds: 1500),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: isLight ? ColorsApp.white : ColorsApp.slate700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(999),
                                child: Ink(
                                  height: 32,
                                  width: 32,
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () async {
                                      await UpdateCard(
                                          cardNumberCtrl.text,
                                          expiryFieldCtrl.text,
                                          cardhodlCtrl.text,
                                          cvvCtrl.text);
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/cloud-upload.svg",
                                      color: isLight
                                          ? ColorsApp.slate900
                                          : ColorsApp.slate100,
                                    ),
                                  ),
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
          ),
          //--头部结束
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElasticInUp(
                      from: 1000,
                      delay: const Duration(milliseconds: 100),
                      duration: const Duration(milliseconds: 1500),
                      child: CreditCard(
                        cardNumber: cardNumber,
                        cardExpiry: expiryDate,
                        cardHolderName: cardHolderName,
                        cvv: cvv,
                        bankName: '天地银行',
                        showBackSide: showBack,
                        frontBackground: CardBackgrounds.black,
                        backBackground: CardBackgrounds.white,
                        showShadow: true,
                        // mask: getCardTypeMask(cardType: CardType.americanExpress),
                      )),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElasticInUp(
                    from: 1000,
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 1500),
                    child: Center(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: cardNumberCtrl,
                            decoration: InputDecoration(hintText: '卡号'),
                            maxLength: 16,
                            onChanged: (value) {
                              final newCardNumber = value.trim();
                              var newStr = '';
                              final step = 4;
                              for (var i = 0;
                                  i < newCardNumber.length;
                                  i += step) {
                                newStr += newCardNumber.substring(i,
                                    math.min(i + step, newCardNumber.length));
                                if (i + step < newCardNumber.length)
                                  newStr += ' ';
                              }
                              setState(() {
                                cardNumber = newStr;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: expiryFieldCtrl,
                            decoration: InputDecoration(hintText: '有效期XX/XX'),
                            maxLength: 5,
                            onChanged: (value) {
                              var newDateValue = value.trim();
                              final isPressingBackspace =
                                  expiryDate.length > newDateValue.length;
                              final containsSlash = newDateValue.contains('/');
                              if (newDateValue.length >= 2 &&
                                  !containsSlash &&
                                  !isPressingBackspace) {
                                newDateValue = newDateValue.substring(0, 2) +
                                    '/' +
                                    newDateValue.substring(2);
                              }
                              setState(() {
                                expiryFieldCtrl.text = newDateValue;
                                expiryFieldCtrl.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: newDateValue.length));
                                expiryDate = newDateValue;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: cardhodlCtrl,
                            decoration: InputDecoration(hintText: '持卡人姓名'),
                            onChanged: (value) {
                              setState(() {
                                cardHolderName = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: cvvCtrl,
                            decoration: InputDecoration(hintText: 'CVV'),
                            maxLength: 3,
                            onChanged: (value) {
                              setState(() {
                                cvv = value;
                              });
                            },
                            focusNode: _focusNode,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
