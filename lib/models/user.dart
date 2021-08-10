import 'package:dekornata_app_test/models/product.dart';

class User {
  int id;
  String name;
  String address;
  String phoneNum;
  List<Product> cartItems;

  User(this.id, this.name, this.address, this.phoneNum, this.cartItems);
}
