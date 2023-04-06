import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soping/src/util/localization/loadToken.dart';

import '../../models/Cartitme.dart';
import '../../styles/colors_app.dart';
import '../../util/http/Productapi_uitl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [];
  String? token;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      token = await ReadToken();
      final cartItems = await getcartit(token!);
      setState(() {
        _cartItems = cartItems;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var cartItem in _cartItems) {
      total += cartItem.totalPrice;
    }
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
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    ElasticIn(
                      duration: const Duration(milliseconds: 1500),
                      child: GestureDetector(
                        onTap: () => Get.offNamed("Home"),
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
          //--头部结束
          SliverToBoxAdapter(
            child: ElasticInUp(
              duration: Duration(milliseconds: 1000),
              child: Container(
                height: 500,
                child: ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = _cartItems[index];

                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            cartItem.product.images[0],
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(cartItem.product.name),
                        subtitle: Text(
                          '¥${cartItem.product.price}',
                          style: TextStyle(color: ColorsApp.rose500),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                token = await ReadToken();
                                deleteCart(cartItem.product.id, token!);
                                print(cartItem.id);
                                setState(() {
                                  cartItem.quantity--;
                                  if (cartItem.quantity == 0) {
                                    _cartItems
                                        .removeAt(index); // 数量为0时从购物车中删除该商品记录
                                  }
                                });
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text('${cartItem.quantity}'),
                            IconButton(
                              onPressed: () async {
                                token = await ReadToken();
                                addCart(cartItem.product.id, token!);
                                setState(() {
                                  cartItem.quantity++;
                                });
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          )
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
                  child: ElevatedButton(
                    onPressed: () async {
                      String? token = await ReadToken();
                      String? orderno = await createOrder(token!);
                      if (orderno == null) {
                      } else {
                        Get.toNamed('OrderDetailScreen', arguments: orderno);
                      }
                    },
                    child: Text("创建订单|${total.toStringAsFixed(2)}"),
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
