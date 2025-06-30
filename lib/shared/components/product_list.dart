import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/shared/components/product_card.dart';
import 'package:market_app/shared/functions/showMsg.dart';

import '../../models/product_model.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.searchText,
    this.category,
    this.isFavoriteScreen = false,
    this.isMyOrdersScreen = false,
  });
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? searchText;
  final String? category;
  final bool? isFavoriteScreen;
  final bool? isMyOrdersScreen;

  List<ProductModel> _getProducts(context) {
    if (searchText != null) {
      return HomeCubit.get(context).searchedProducts;
    } else if (category != null) {
      return HomeCubit.get(context).categoryProducts;
    } else if (isFavoriteScreen == true) {
      return HomeCubit.get(context).favoriteProductsList;
    } else if (isMyOrdersScreen == true) {
      return HomeCubit.get(context).userOrders;
    } else {
      return HomeCubit.get(context).products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeCubit()..getProducts(searchText: searchText, category: category),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext context, state) {
          if (state is BuyProductSuccess) {
            showMsg(context, text: "product purchased, Thanks");
          }
        },
        builder: (BuildContext context, state) {
          List<ProductModel> products = _getProducts(context);
          return state is GetDataLoading
              ? Center(child: CircularProgressIndicator())
              : products.isEmpty
              ? Text("No Products Found")
              : ListView.builder(
                  shrinkWrap: shrinkWrap ?? true,
                  physics: physics ?? NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ProductCard(
                      isFavorite: HomeCubit.get(
                        context,
                      ).checkFavoriteProducts(products[index].productId!),
                      product: products[index],
                      onTap: () {
                        bool isFavorite = HomeCubit.get(
                          context,
                        ).checkFavoriteProducts(products[index].productId!);
                        isFavorite
                            ? HomeCubit.get(context).removeProductFromFavorite(
                                products[index].productId!,
                              )
                            : HomeCubit.get(context).addProductToFavorite(
                                products[index].productId!,
                              );
                      },
                      onPaymentSuccess: () async {
                        await HomeCubit.get(
                          context,
                        ).addProductToPurchased(products[index].productId!);
                      },
                      isBought: HomeCubit.get(
                        context,
                      ).checkBoughtProducts(products[index].productId!),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
