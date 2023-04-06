import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soping/src/util/http/Productapi_uitl.dart';

import '../../models/model_orderlist.dart';
import '../../styles/colors_app.dart';
import '../../util/localization/loadToken.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<DataRow> rows = [];
  List<dynamic> _data = [];
  Orderlist? _order;
  @override
  void initState() {
    super.initState();
    _loadorder();
  }

  Future<void> _loadorder() async {
    try {
      String? token = await ReadToken();
      List<dynamic> data = (await getorder(token!));

      print("data:${data[0]['orderNo']}");
      // final orders = Orderlist.fromJson(data.);
      // for (final order in orders) {
      //   print(order);
      //   // 执行其他操作
      // }
      setState(() {
        _data = data;
        //_order = order;
        // rows = List.generate(
        //     order,
        //     (index) => DataRow(cells: [
        //           DataCell(
        //             Text(order.productList[index].productid.toString()),
        //           ),
        //           DataCell(Text(order.productList[index].name.toString())),
        //           DataCell(Text(
        //               '¥${order.productList[index].price.toStringAsFixed(2)}'))
        //         ]));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;

    final headerStyle = TextStyle(
        color: isLight ? ColorsApp.neutral100 : ColorsApp.slate900,
        fontSize: 15,
        fontWeight: FontWeight.bold);
    const contentStyle = TextStyle(
        color: ColorsApp.black, fontSize: 14, fontWeight: FontWeight.normal);
    const contentStyleHeader = TextStyle(
        color: ColorsApp.slate900, fontSize: 14, fontWeight: FontWeight.w700);
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
                padding: const EdgeInsets.all(25),
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
                  ],
                ),
              ),
            ),
          ),
          //头部结束
          SliverToBoxAdapter(
            child: ElasticInUp(
              duration: const Duration(milliseconds: 1000),
              child: Container(
                  height: 800,
                  child: ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) => Accordion(
                      maxOpenSections: 2,
                      headerBackgroundColorOpened:
                          isLight ? ColorsApp.neutral100 : ColorsApp.slate900,
                      scaleWhenAnimating: true,
                      openAndCloseAnimation: true,
                      headerPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 15),
                      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                      sectionClosingHapticFeedback: SectionHapticFeedback.light,
                      children: [
                        AccordionSection(
                          headerBackgroundColor:
                              isLight ? ColorsApp.slate900 : ColorsApp.slate50,
                          isOpen: false,
                          leftIcon:
                              const Icon(Icons.food_bank, color: Colors.white),
                          header: Text('订单信息|${_data[index]['createdTime']}',
                              style: headerStyle),
                          content: Column(children: [
                            Text(
                              '订单号:${_data[index]['orderNo']}',
                              style: contentStyle,
                            ),
                            const Divider(),
                            Text(
                              '地址:${_data[index]['receiverAddress']}',
                              style: contentStyle,
                            ),
                            const Divider(),
                            Text(
                              "总计:${_data[index]['totalAmount']}元",
                              style: contentStyle,
                            ),
                            Text(
                                "状态:${_data[index]['status'] == 1 ? '已支付' : '未支付'}"),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    String? token = await ReadToken();
                                    await deleteorder(
                                        token!, _data[index]['orderNo']);
                                    setState(() {
                                      _data.remove(_data[index]);
                                    });
                                  },
                                  child: Text("删除订单"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isLight
                                        ? ColorsApp.slate900
                                        : ColorsApp.slate100,
                                    foregroundColor: isLight
                                        ? ColorsApp.white
                                        : ColorsApp.slate900,
                                    elevation: 0,
                                    padding: const EdgeInsets.all(10),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    textStyle: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed('OrderDetailScreen',
                                        arguments: _data[index]['orderNo']);
                                  },
                                  child: Text("查看订单"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsApp.slate900,
                                    foregroundColor: ColorsApp.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.all(10),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    textStyle: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
