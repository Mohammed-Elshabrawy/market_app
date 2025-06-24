part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class GetRatesLoading extends ProductDetailsState {}

final class GetRatesSuccess extends ProductDetailsState {}

final class GetRatesError extends ProductDetailsState {}

final class AddOrUpdateRateLoading extends ProductDetailsState {}

final class AddOrUpdateRateSuccess extends ProductDetailsState {}

final class AddOrUpdateRateError extends ProductDetailsState {}
