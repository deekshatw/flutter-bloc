import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_bloc/features/cart/ui/cart.dart';
import 'package:tutorial_bloc/features/home/bloc/home_bloc.dart';
import 'package:tutorial_bloc/features/home/ui/product_tile_widget.dart';
import 'package:tutorial_bloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Product added to cart'),
            duration: Duration(seconds: 2),
          ));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Product wishlisted'),
            duration: Duration(seconds: 2),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Colors.teal),
              ),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text('My Grocery App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                        productDataModel: successState.products[index],
                        homeBloc: homeBloc,
                      );
                    }),
              ),
            );

          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
