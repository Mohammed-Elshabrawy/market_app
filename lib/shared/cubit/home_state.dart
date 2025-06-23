
sealed class HomeStates {}

final class HomeInitial extends HomeStates {}

final class GetDataLoading extends HomeStates {}
final class GetDataSuccess extends HomeStates {}
final class GetDataError extends HomeStates {}

