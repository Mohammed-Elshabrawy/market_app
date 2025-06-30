sealed class HomeStates {}

final class HomeInitial extends HomeStates {}

final class GetDataLoading extends HomeStates {}

final class GetDataSuccess extends HomeStates {}

final class GetDataError extends HomeStates {}

final class AddProductToFavoriteLoading extends HomeStates {}

final class AddProductToFavoriteSuccess extends HomeStates {}

final class AddProductToFavoriteError extends HomeStates {}

final class RemoveProductToFavoriteLoading extends HomeStates {}

final class RemoveProductToFavoriteSuccess extends HomeStates {}

final class RemoveProductToFavoriteError extends HomeStates {}

final class BuyProductLoading extends HomeStates {}

final class BuyProductSuccess extends HomeStates {}

final class BuyProductError extends HomeStates {}
