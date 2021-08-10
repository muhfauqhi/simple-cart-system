import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dekornata_app_test/models/cart.dart';
import 'package:dekornata_app_test/models/product.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Product> cartItems = [];
  List<Product> selectedCart = [];

  CartBloc() : super(CartInitial()) {
    add(CartInitializedEvent());
  }

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartInitializedEvent) {
      Cart cart = Cart(cartItems, selectedCart);
      yield CartLoadCartState(cart);
    }
    if (event is AddCartEvent) {
      Cart cart;
      if (cartItems.contains(event.product) && event.product.stock > 0) {
        cartItems.forEach((product) {
          if (product == event.product &&
              (event.product.stock > product.quantity)) {
            product.quantity++;
          }
        });
      } else if (event.product.stock > 0) {
        cartItems.add(event.product);
      }
      cart = Cart(cartItems, selectedCart);
      yield ProductAddCartState(cart);
      yield CartLoadCartState(Cart(cartItems, selectedCart));
    }
    if (event is RemoveCartEvent) {
      event.product.quantity = 1;
      cartItems.remove(event.product);
      selectedCart.remove(event.product);
      Cart cart = Cart(cartItems, selectedCart);
      yield ProductRemoveCartState(cart);
      yield CartLoadCartState(cart);
    }
    if (event is SubtractingCartEvent) {
      if (cartItems.contains(event.product)) {
        cartItems.forEach((product) {
          if (product == event.product && (product.quantity > 1)) {
            product.quantity--;
          }
        });
      }
      Cart cart = Cart(cartItems, selectedCart);
      yield ProductRemoveCartState(cart);
      yield CartLoadCartState(cart);
    }
    if (event is SelectCartEvent) {
      if (selectedCart.contains(event.product)) {
        selectedCart.remove(event.product);
      } else {
        selectedCart.add(event.product);
      }
      Cart cart = Cart(cartItems, selectedCart);
      yield SelectedCartState(cart);
      yield CartLoadCartState(cart);
    }
    if (event is SelectAllCartEvent) {
      if (selectedCart.length == cartItems.length) {
        selectedCart = [];
      } else {
        selectedCart = [];
        selectedCart.addAll(cartItems);
      }
      Cart cart = Cart(cartItems, selectedCart);
      yield SelectedCartState(cart);
      yield CartLoadCartState(cart);
    }
    if (event is CheckoutEvent) {
      selectedCart.forEach((items) {
        cartItems.remove(items);
      });
      selectedCart = [];
      Cart cart = Cart(cartItems, selectedCart);
      yield CheckoutCartState();
      yield CartLoadCartState(cart);
    }
  }
}
