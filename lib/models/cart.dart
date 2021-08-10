import 'package:dekornata_app_test/models/product.dart';

class Cart {
  List<Product> cartItems;
  List<Product> selectedCart;

  Cart(this.cartItems, this.selectedCart);
}
