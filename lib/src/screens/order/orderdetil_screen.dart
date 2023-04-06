import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:soping/src/models/model_order.dart';
import 'package:soping/src/util/http/Productapi_uitl.dart';
import 'package:soping/src/util/http/Userapi_util.dart';

import '../../styles/colors_app.dart';
import '../../util/localization/loadToken.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List<DataRow> rows = [];
  Order? _order;
  @override
  void initState() {
    super.initState();
    _loadorder();
  }

  Future<void> _loadorder() async {
    try {
      String? token = await ReadToken();
      print("new${Get.arguments}");
      final data = await getorderforid(token!, Get.arguments);
      final order = Order.fromJson(data);
      setState(() {
        _order = order;
        rows = List<DataRow>.generate(
            order.productList.length,
            (index) => DataRow(cells: [
                  DataCell(
                    Text(order.productList[index].productid.toString()),
                  ),
                  DataCell(Text(order.productList[index].name.toString())),
                  DataCell(Text(
                      '¥${order.productList[index].price.toStringAsFixed(2)}'))
                ]));
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
                height: 500,
                child: Accordion(
                  maxOpenSections: 2,
                  headerBackgroundColorOpened:
                      isLight ? ColorsApp.neutral100 : ColorsApp.slate900,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: [
                    AccordionSection(
                      contentBackgroundColor:
                          isLight ? ColorsApp.slate50 : ColorsApp.slate900,
                      headerBackgroundColorOpened: ColorsApp.orange400,
                      headerBackgroundColor:
                          isLight ? ColorsApp.slate900 : ColorsApp.slate50,
                      isOpen: false,
                      leftIcon:
                          const Icon(Icons.food_bank, color: Colors.white),
                      header: Text('商品信息', style: headerStyle),
                      content: Column(children: [
                        DataTable(
                            sortAscending: true,
                            sortColumnIndex: 1,
                            dataRowHeight: 40,
                            showBottomBorder: false,
                            columns: const [
                              DataColumn(
                                  label: Text('ID', style: contentStyleHeader),
                                  numeric: true),
                              DataColumn(
                                  label:
                                      Text('商品名称', style: contentStyleHeader)),
                              DataColumn(
                                  label: Text('价格', style: contentStyleHeader),
                                  numeric: true),
                            ],
                            rows: rows),
                        Divider(),
                        Text(
                          '共计:${_order?.totalAmount.toStringAsFixed(2)}元',
                          style: TextStyle(color: ColorsApp.rose400),
                        )
                      ]),
                    ),
                    AccordionSection(
                      contentBackgroundColor:
                          isLight ? ColorsApp.slate50 : ColorsApp.slate900,
                      headerBackgroundColorOpened: ColorsApp.orange400,
                      headerBackgroundColor:
                          isLight ? ColorsApp.slate900 : Colors.yellow,
                      isOpen: true,
                      leftIcon:
                          const Icon(Icons.food_bank, color: Colors.white),
                      header: Text('地址信息', style: headerStyle),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("地址:${_order?.receiverAddress}"),
                          const Divider(),
                          Text(
                              "收件人:${_order?.receiverName},电话:${_order?.receiverPhone}"),
                          Visibility(
                            visible: _order?.status == 1 ? false : true,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed('EditProfile');
                              },
                              child: Text('修改'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsApp.slate900),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AccordionSection(
                      contentBackgroundColor:
                          isLight ? ColorsApp.slate50 : ColorsApp.slate900,
                      headerBackgroundColorOpened: ColorsApp.orange400,
                      headerBackgroundColor: ColorsApp.slate900,
                      isOpen: true,
                      leftIcon:
                          const Icon(Icons.food_bank, color: Colors.white),
                      header: Text('订单信息', style: headerStyle),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("订单号:${_order?.orderno}"),
                          const Divider(),
                          Text("订单状态:${_order?.status == 1 ? '已支付' : '未支付'}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElasticIn(
          delay: const Duration(milliseconds: 1500),
          duration: const Duration(milliseconds: 1500),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: isLight ? ColorsApp.white : ColorsApp.slate700,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Visibility(
                    visible: _order?.status == 1 ? false : true,
                    child: ElevatedButton(
                      onPressed: () async {
                        String? token = await ReadToken();
                        final data = await getcard(token!);
                        if (data == null) {
                          Get.snackbar("支付失败", "还没有绑定银行卡",
                              snackPosition: SnackPosition.TOP);
                        } else {
                          await updateorder(token!, _order!.orderno);
                          setState(() {
                            _order?.status = 1;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isLight ? ColorsApp.slate900 : ColorsApp.slate100,
                        foregroundColor:
                            isLight ? ColorsApp.white : ColorsApp.slate900,
                        elevation: 0,
                        padding: const EdgeInsets.all(20),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(
                          fontSize: 13,
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
                      child:
                          Text("支付|${_order?.totalAmount.toStringAsFixed(2)}元"),
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
}
