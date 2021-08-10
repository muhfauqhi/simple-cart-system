part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoadCartState extends CartState {
  Cart cart;

  CartLoadCartState(this.cart);
}

class ProductAddCartState extends CartState {
  Cart cart;
  ProductAddCartState(this.cart);
}

class ProductRemoveCartState extends CartState {
  Cart cart;
  ProductRemoveCartState(this.cart);
}

class SelectedCartState extends CartState {
  Cart cart;
  SelectedCartState(this.cart);
}

class CheckoutCartState extends CartState {
  CheckoutCartState();
}
