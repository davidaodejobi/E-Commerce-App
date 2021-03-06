import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '/provider/provider.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _isLoading = true;

    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // bool _isInit = true;
  // @override
  // void dispose() {
  //   _isLoading;
  //   super.dispose();
  // }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Products>(context, listen: false)
  //         .fetchAndSetProducts()
  //         .then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }

  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    final filterProduct = Provider.of<Filter>(context).selectedOption;

    final products =
        filterProduct ? productsData.favoriteItems : productsData.items;

    Size size = MediaQuery.of(context).size;

    return _isLoading
        ? Center(
            child: Lottie.asset(
              'assets/animations/loading.json',
            ),
          )
        : GridView.builder(
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
