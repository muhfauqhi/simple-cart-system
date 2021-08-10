part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductUpdateStockState extends ProductState {
  ProductData productData;
  ProductUpdateStockState(this.productData);
}

class ProductLoadedState extends ProductState {
  ProductData productData;
  ProductLoadedState(this.productData);
}
