part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductInitializedEvent extends ProductEvent {}

class ProductUpdateStockEvent extends ProductEvent {
  List<Product> products;

  ProductUpdateStockEvent(this.products);
}
