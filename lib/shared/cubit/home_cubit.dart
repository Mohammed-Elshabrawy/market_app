import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/product_model.dart';
import '../network/remote/api_services.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;
  List<ProductModel> products = [];
  List<ProductModel> searchedProducts = [];
  List<ProductModel> categoryProducts = [];

  Future<void> getProducts({String? searchText, String? category}) async {
    searchedProducts = [];
    categoryProducts = [];
    products = [];
    userOrders = [];
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
        'products?select=*,favorite_products(*),purchased(*)',
      );
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      getFavoriteProducts();
      searchProducts(searchText);
      getProductsByCategory(category);
      getUserOrders();
      emit(GetDataSuccess());
    } catch (e) {
      emit(GetDataError());
      log(e.toString());
    }
  }

  Future<void> addProductToFavorite(String productId) async {
    emit(AddProductToFavoriteLoading());
    try {
      await _apiServices.postData("favorite_products", {
        "for_product": productId,
        "for_user": userId,
        "is_favorite": true,
      });
      await getProducts();
      favoriteProducts.addAll({productId: true});
      emit(AddProductToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddProductToFavoriteError());
    }
  }

  Future<void> removeProductFromFavorite(String productId) async {
    emit(RemoveProductToFavoriteLoading());
    try {
      await _apiServices.deleteData(
        'favorite_products?for_product=eq.$productId&for_user=eq.$userId',
      );
      await getProducts();
      favoriteProducts.removeWhere((key, value) => key == productId);
      favoriteProductsList.removeWhere(
        (product) => product.productId == productId,
      );
      emit(RemoveProductToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveProductToFavoriteError());
    }
  }

  void searchProducts(String? searchText) {
    if (searchText != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(
          searchText.toLowerCase(),
        )) {
          searchedProducts.add(product);
        }
      }
    }
  }

  void getProductsByCategory(String? category) {
    if (category != null) {
      for (var product in products) {
        if (product.category!.trim().toLowerCase() ==
            category.trim().toLowerCase()) {
          categoryProducts.add(product);
        }
      }
    }
  }

  Map<String, bool> favoriteProducts = {};

  List<ProductModel> favoriteProductsList = [];
  void getFavoriteProducts() {
    for (ProductModel product in products) {
      if (product.favoriteProductsList != null &&
          product.favoriteProductsList!.isNotEmpty) {
        for (FavoriteProducts favoriteProduct
            in product.favoriteProductsList!) {
          if (favoriteProduct.forUser == userId) {
            favoriteProductsList.add(product);
            favoriteProducts.addAll({product.productId!: true});
          }
        }
      }
    }
  }

  bool checkFavoriteProducts(String productId) {
    return favoriteProducts.containsKey(productId);
  }

  Future<void> addProductToPurchased(String productId) async {
    emit(BuyProductLoading());
    try {
      await _apiServices.postData("purchased", {
        "for_product": productId,
        "for_user": userId,
        "is_bought": true,
      });
      // await getProducts();
      emit(BuyProductSuccess());
    } catch (e) {
      log(e.toString());
      emit(BuyProductError());
    }
  }

  List<ProductModel> userOrders = [];
  void getUserOrders() {
    for (ProductModel product in products) {
      if (product.purchasedList != null && product.purchasedList!.isNotEmpty) {
        for (Purchased userOrder in product.purchasedList!) {
          if (userOrder.forUser == userId) {
            userOrders.add(product);
          }
        }
      }
    }
  }

  bool checkBoughtProducts(String productId) {
    return userOrders.any((product) => product.productId == productId);
  }
}
