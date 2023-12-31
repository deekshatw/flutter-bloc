part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemovedFromWishlistEvent extends WishlistEvent {
  final ProductDataModel productDataModel;

  WishlistRemovedFromWishlistEvent(this.productDataModel);
}
