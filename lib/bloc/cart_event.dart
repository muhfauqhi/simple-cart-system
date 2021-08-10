part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitializedEvent extends CartEvent {}

class AddCartEvent extends CartEvent {
  Product product;

  AddCartEvent(this.product);
}

class AddingCartEvent extends CartEvent {
  Product product;

  AddingCartEvent(this.product);
}

class SubtractingCartEvent extends CartEvent {
  Product product;

  SubtractingCartEvent(this.product);
}

class RemoveCartEvent extends CartEvent {
  Product product;

  RemoveCartEvent(this.product);
}

class SelectCartEvent extends CartEvent {
  Product product;

  SelectCartEvent(this.product);
}

class SelectAllCartEvent extends CartEvent {
  List<Product> products;

  SelectAllCartEvent(this.products);
}

class CheckoutEvent extends CartEvent {
  List<Product> products;

  CheckoutEvent(this.products);
}
