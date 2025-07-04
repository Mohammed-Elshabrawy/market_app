import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/shared/network/remote/api_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../models/rate_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  static ProductDetailsCubit get(context) => BlocProvider.of(context);
  SupabaseClient supabase = Supabase.instance.client;
  final ApiServices _apiServices = ApiServices();
  String? userId() => Supabase.instance.client.auth.currentUser?.id;
  List<RateModel> rates = [];
  int userRate = 5;
  int averageRate = 0;
  Future<void> getRates({required String productId}) async {
    emit(GetRatesLoading());
    try {
      final response = await _apiServices.getData(
        'rates?select=*&for_product=eq.$productId',
      );
      for (var rate in response.data) {
        rates.add(RateModel.fromJson(rate));
      }
      _getAverageRate();
      _getUserRate();
      emit(GetRatesSuccess());
    } catch (e) {
      emit(GetRatesError());
    }
  }

  void _getUserRate() {
    List<RateModel> userRates = rates
        .where((RateModel rate) => rate.forUser == userId())
        .toList();
    userRate = userRates.isNotEmpty ? userRates[0].rate! : 5;
  }

  void _getAverageRate() {
    for (var userRate in rates) {
      if (userRate.rate != null) {
        averageRate += userRate.rate!;
      }
    }
    if (rates.isNotEmpty) {
      averageRate = (averageRate / rates.length).toInt();
    }
  }

  bool _checkUserRateExist({required String productId}) {
    for (var rate in rates) {
      if (rate.forUser == userId() && rate.forProduct == productId) {
        return true;
      }
    }
    return false;
  }

  Future<void> addOrUpdateRate({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    emit(AddOrUpdateRateLoading());
    try {
      String path =
          "rates?select=*&for_user=eq.$userId()8&for_product=eq.$productId";
      if (_checkUserRateExist(productId: productId)) {
        //await _apiServices.patchData(path, data);
        await supabase
            .from('rates')
            .update({"rate": data['rate']})
            .eq('for_user', userId() as Object)
            .eq('for_product', productId);
      } else {
        await _apiServices.postData(path, data);
      }
      emit(AddOrUpdateRateSuccess());
    } catch (e) {
      emit(AddOrUpdateRateError());
    }
  }

  Future<void> addComment({required Map<String, dynamic> data}) async {
    emit(AddCommentLoading());
    try {
      await _apiServices.postData('comments', data);
      emit(AddCommentSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddCommentError());
    }
  }
}
