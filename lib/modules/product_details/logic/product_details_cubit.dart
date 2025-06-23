import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/shared/network/remote/api_services.dart';

import '../../../models/rate_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(super.initialState);

  final ApiServices _apiServices = ApiServices();
  List<RateModel> rates = [];
  int averageRate = 0;
  Future<void> getRates({required String productId}) async {
    emit(GetRatesLoading());
    try {
      final response = await _apiServices.getData(
        'rates?select=*&for_product=eq.$productId',
      );
      for (var rate in response.data) {
        rates.add(RateModel.fromJson(rate));
        emit(GetRatesSuccess());
      }
    } catch (e) {
      log(e.toString());
      emit(GetRatesError());
    }
  }
}
