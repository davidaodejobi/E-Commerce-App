import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/models.dart';
import '/widgets/widgets.dart';
import '../constant.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<Products>(context, listen: false).fetchAndSetProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    final filterProduct = Provider.of<Filter>(context).selectedOption;

    final products =
        filterProduct ? productsData.favoriteItems : productsData.items;

    Size size = MediaQuery.of(context).size;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: kDefaultPadding / 2,
        mainAxisSpacing: kDefaultPadding,
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisExtent: size.height * 0.35,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: const ProductListItem(),
      ),
    );
  }
}
