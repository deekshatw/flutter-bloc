part of 'home_bloc.dart';

@immutable
sealed class HomeState {} //this is for rebuilding the UI according to different states.

abstract class HomeActionState
    extends HomeState {} // this is for the actions taking place like navigating to different screens.

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}
