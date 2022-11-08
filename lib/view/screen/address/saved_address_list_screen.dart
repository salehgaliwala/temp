import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/address/widget/address_list_screen.dart';
import 'package:provider/provider.dart';
class SavedAddressListScreen extends StatelessWidget {
  const SavedAddressListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                profile.addressList != null ? profile.addressList.length != 0 ?  SizedBox(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: profile.addressList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {Provider.of<OrderProvider>(context, listen: false).setAddressIndex(index);
                        Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorResources.getIconBg(context),
                            border: index == Provider.of<OrderProvider>(context).addressIndex ? Border.all(width: 2, color: Theme.of(context).primaryColor) : null,
                          ),
                          child: AddressListPage(address: profile.addressList[index]),
                        ),
                      );
                    },
                  ),
                )  : Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                  child: Center(child: Text(getTranslated('no_address_available', context),style: titilliumRegular,)),
                ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
              ],
            ),
          );
        },
      )),
    );
  }
}
