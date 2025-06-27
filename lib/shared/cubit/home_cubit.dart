import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';
import '../network/remote/api_services.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  final ApiServices _apiServices = ApiServices();
  List<ProductModel> products = [];
  List<ProductModel> searchedProducts = [];

  Future<void> getProducts({String? searchText}) async {
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
        'products?select=*,favorite_products(*),purchased(*)',
      );
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      searchProducts(searchText);
      emit(GetDataSuccess());
    } catch (e) {
      emit(GetDataError());
    }
  }

  void searchProducts(String? searchText) {
    if (searchText != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(
          searchText.toLowerCase(),
        )) {
          searchedProducts.add(product);
          print(product.productName);
        }
      }
    }
  }
}
