import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/order_place_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/coupon_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/amount_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/my_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/add_new_address_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/address_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/saved_address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/saved_billing_Address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/widget/address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/custom_check_box.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/payment/payment_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/checkout_screen.dart';

class ShippingScreen extends StatefulWidget {
  final List<CartModel> cartList;
  final bool fromProductDetails;
  final double totalOrderAmount;
  final double shippingFee;
  final double discount;
  final double tax;
  final int sellerId;

  ShippingScreen(
      {@required this.cartList,
      this.fromProductDetails = false,
      @required this.discount,
      @required this.tax,
      @required this.totalOrderAmount,
      @required this.shippingFee,
      this.sellerId});

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false)
        .initAddressList(context);
    Provider.of<ProfileProvider>(context, listen: false)
        .initAddressTypeList(context);
    Provider.of<CouponProvider>(context, listen: false).removePrevCouponData();
    Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
    Provider.of<CartProvider>(context, listen: false)
        .getChosenShippingMethod(context);
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
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        bottomNavigationBar: Container(
          height: 60,
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE,
              vertical: Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
            color: ColorResources.getPrimary(context),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Center(
                    child: Text(
              PriceConverter.convertPrice(context, amount + shippingAmount),
              style: titilliumSemiBold.copyWith(
                  color: Theme.of(context).highlightColor),
            ))),
            Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  if (Provider.of<AuthProvider>(context, listen: false)
                      .isLoggedIn()) {
                    if (cart.cartList.length == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(getTranslated(
                            'select_at_least_one_product', context)),
                        backgroundColor: Colors.red,
                      ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CheckoutScreen(
                                    cartList: cartList,
                                    totalOrderAmount: amount,
                                    shippingFee: shippingAmount,
                                    discount: discount,
                                    tax: tax,
                                  )));
                    }
                  } else {
                    showAnimatedDialog(context, GuestDialog(), isFlip: true);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).highlightColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Passez au paiement',
                    style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      color: ColorResources.getPrimary(context),
                    )),
              ),
            ),
          ]),
        ),
        body: Column(
          children: [
            CustomAppBar(title: getTranslated('delivery_address', context)),
            Expanded(
              child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  children: [
                    // Shipping Details
                    Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor),
                      child: Column(children: [
                        Row(
                          children: [
                            Text('${getTranslated('SHIPPING_TO', context)} : ',
                                style: titilliumRegular.copyWith(
                                    fontWeight: FontWeight.w600)),
                            Expanded(
                              child: Text(
                                Provider.of<OrderProvider>(context)
                                            .addressIndex ==
                                        null
                                    ? getTranslated('add_your_address', context)
                                    : Provider.of<ProfileProvider>(context,
                                            listen: false)
                                        .addressList[Provider.of<OrderProvider>(
                                                context,
                                                listen: false)
                                            .addressIndex]
                                        .address,
                                style: titilliumRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL),
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AddNewAddressScreen(
                                              isBilling: false))),
                              icon: Icon(
                                // <-- Icon
                                Icons.add,
                                size: 24.0,
                              ),
                              label: Text('Ajouter'), // <-- Text
                              style: ElevatedButton.styleFrom(
                                  primary: ColorResources.getPrimary(context)),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SavedAddressListScreen())),
                              icon: Icon(
                                // <-- Icon
                                Icons.edit,
                                size: 24.0,
                              ),
                              label: Text('Sélectionner'), // <-- Text
                              style: ElevatedButton.styleFrom(
                                  primary: ColorResources.getPrimary(context)),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      ]),
                    ),

                    // Order Details

                    // Total bill

                    // Payment Method
                  ]),
            ),
          ],
        ),
      );
    });
  }
}
