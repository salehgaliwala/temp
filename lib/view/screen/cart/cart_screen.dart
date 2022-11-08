import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/cart/widget/cart_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/checkout_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/shipping_address.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/shipping_method_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final bool fromCheckout;
  final int sellerId;
  CartScreen({this.fromCheckout = false, this.sellerId = 1});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
      Provider.of<CartProvider>(context, listen: false).setCartData();

      if (Provider.of<SplashProvider>(context, listen: false)
              .configModel
              .shippingMethod !=
          'sellerwise_shipping') {
        Provider.of<CartProvider>(context, listen: false)
            .getAdminShippingMethodList(context);
      }
    }
    //Provider.of<CartProvider>(context, listen: false).getChosenShippingMethod(context);
    // Provider.of<CartProvider>(context, listen: false).getShippingMethod(context,widget.sellerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      double amount = 0.0;
      double shippingAmount = 0.0;
      double discount = 0.0;
      double tax = 0.0;
      List<CartModel> cartList = [];
      cartList.addAll(cart.cartList);

      //TODO: seller

      List<String> sellerList = [];
      List<CartModel> sellerGroupList = [];
      List<List<CartModel>> cartProductList = [];
      List<List<int>> cartProductIndexList = [];
      cartList.forEach((cart) {
        if (!sellerList.contains(cart.cartGroupId)) {
          sellerList.add(cart.cartGroupId);
          sellerGroupList.add(cart);
        }
      });

      sellerList.forEach((seller) {
        List<CartModel> cartLists = [];
        List<int> indexList = [];
        cartList.forEach((cart) {
          if (seller == cart.cartGroupId) {
            cartLists.add(cart);
            indexList.add(cartList.indexOf(cart));
          }
        });
        cartProductList.add(cartLists);
        cartProductIndexList.add(indexList);
      });

      if (cart.getData &&
          Provider.of<AuthProvider>(context, listen: false).isLoggedIn() &&
          Provider.of<SplashProvider>(context, listen: false)
                  .configModel
                  .shippingMethod ==
              'sellerwise_shipping') {
        Provider.of<CartProvider>(context, listen: false)
            .getShippingMethod(context, cartProductList);
      }

      for (int i = 0; i < cart.cartList.length; i++) {
        amount += (cart.cartList[i].price - cart.cartList[i].discount) *
            cart.cartList[i].quantity;
        discount += cart.cartList[i].discount * cart.cartList[i].quantity;
        tax += cart.cartList[i].tax * cart.cartList[i].quantity;
      }
      for (int i = 0; i < cart.chosenShippingList.length; i++) {
        shippingAmount += cart.chosenShippingList[i].shippingCost;
      }
      // amount += shippingAmount;

      return Scaffold(
        bottomNavigationBar: (!widget.fromCheckout && !cart.isLoading)
            ? Container(
                height: 60,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE,
                    vertical: Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  color: ColorResources.getPrimary(context),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Center(
                              child: Text(
                        PriceConverter.convertPrice(
                            context, amount + shippingAmount),
                        style: titilliumSemiBold.copyWith(
                            color: Theme.of(context).highlightColor),
                      ))),
                      Builder(
                        builder: (context) => TextButton(
                          onPressed: () {
                            if (Provider.of<AuthProvider>(context,
                                    listen: false)
                                .isLoggedIn()) {
                              if (cart.cartList.length == 0) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(getTranslated(
                                      'select_at_least_one_product', context)),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ShippingScreen(
                                              cartList: cartList,
                                              totalOrderAmount: amount,
                                              shippingFee: shippingAmount,
                                              discount: discount,
                                              tax: tax,
                                            )));
                              }
                            } else {
                              showAnimatedDialog(context, GuestDialog(),
                                  isFlip: true);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).highlightColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(getTranslated('checkout', context),
                              style: titilliumSemiBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                color: ColorResources.getPrimary(context),
                              )),
                        ),
                      ),
                    ]),
              )
            : null,
        body: Column(children: [
          CustomAppBar(title: getTranslated('CART', context)),
          cart.isLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              : sellerList.length != 0
                  ? Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  if (Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .isLoggedIn()) {
                                    await Provider.of<CartProvider>(context,
                                            listen: false)
                                        .getCartDataAPI(context);
                                  }
                                },
                                child: ListView.builder(
                                  itemCount: sellerList.length,
                                  padding: EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom:
                                              Dimensions.PADDING_SIZE_LARGE),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            sellerGroupList[index]
                                                    .shopInfo
                                                    .isNotEmpty
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        sellerGroupList[index]
                                                            .shopInfo,
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: titilliumSemiBold
                                                            .copyWith(
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE,
                                                        )),
                                                  )
                                                : SizedBox(),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: Dimensions
                                                      .PADDING_SIZE_LARGE),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        spreadRadius: 1,
                                                        blurRadius: 3,
                                                        offset: Offset(0, 3)),
                                                  ]),
                                              child: Column(
                                                children: [
                                                  ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.all(0),
                                                    itemCount:
                                                        cartProductList[index]
                                                            .length,
                                                    itemBuilder: (context, i) =>
                                                        CartWidget(
                                                      cartModel:
                                                          cartProductList[index]
                                                              [i],
                                                      index:
                                                          cartProductIndexList[
                                                              index][i],
                                                      fromCheckout:
                                                          widget.fromCheckout,
                                                    ),
                                                  ),
                                                  Provider.of<SplashProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .configModel
                                                              .shippingMethod ==
                                                          'sellerwise_shipping'
                                                      ? Padding(
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: Dimensions
                                                                  .PADDING_SIZE_DEFAULT),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Provider.of<SplashProvider>(context, listen: false)
                                        .configModel
                                        .shippingMethod !=
                                    'sellerwise_shipping'
                                ? InkWell(
                                    onTap: () {
                                      if (Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .isLoggedIn()) {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) =>
                                              ShippingMethodBottomSheet(
                                                  groupId: 'all_cart_group',
                                                  sellerIndex: 0,
                                                  sellerId: 1),
                                        );
                                      } else {
                                        showCustomSnackBar(
                                            'not_logged_in', context);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5, color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: NoInternetOrDataScreen(isNoInternet: false)),
        ]),
      );
    });
  }
}
