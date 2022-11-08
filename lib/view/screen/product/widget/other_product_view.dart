import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class OtherProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        return Column(children: [
          prodProvider.otherProductList != null
              ? prodProvider.otherProductList.length != 0
                  ? StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: prodProvider.otherProductList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidget(
                            productModel: prodProvider.otherProductList[index]);
                      },
                    )
                  : Center(child: Text('Aucun autre client voir le produit'))
              : ProductShimmer(
                  isHomePage: false,
                  isEnabled:
                      Provider.of<ProductProvider>(context).otherProductList ==
                          null),
        ]);
      },
    );
  }
}
