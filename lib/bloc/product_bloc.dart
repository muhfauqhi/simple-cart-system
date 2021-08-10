import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dekornata_app_test/models/product.dart';
import 'package:dekornata_app_test/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductDataProvider productProvider = ProductDataProvider();
  List<Product> products = [];

  ProductBloc() : super(ProductInitial()) {
    add(ProductInitializedEvent());
  }

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is ProductInitializedEvent) {
      ProductData productData = await productProvider.getAllProducts();
      products = productData.products;
      yield ProductLoadedState(productData);
    }
    if (event is ProductUpdateStockEvent) {
      products.forEach((product) {
        event.products.forEach((item) {
          if (item.id == product.id) {
            product.stock = product.stock - item.quantity;
            product.quantity = 1;
          }
        });
      });
      yield ProductUpdateStockState(ProductData(products));
      yield ProductLoadedState(ProductData(products));
    }
  }
}
