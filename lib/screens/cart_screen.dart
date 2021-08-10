import 'package:dekornata_app_test/bloc/cart_bloc.dart';
import 'package:dekornata_app_test/bloc/product_bloc.dart';
import 'package:dekornata_app_test/bloc/user_bloc.dart';
import 'package:dekornata_app_test/models/product.dart';
import 'package:dekornata_app_test/screens/confirmation_screen.dart';
import 'package:dekornata_app_test/widgets/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.blue[900],
        toolbarHeight: 100.0,
        centerTitle: true,
        title: Column(
          children: [
            Text('Your Cart'),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Text(
                  cartBloc.cartItems.length.toString() + ' items',
                  style: TextStyle(fontSize: 12.0, color: Colors.white70),
                );
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          List<Product> selectedCart = cartBloc.selectedCart;
          return cartBloc.cartItems.length > 0
              ? Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                cartBloc
                                  ..add(SelectAllCartEvent(cartBloc.cartItems));
                              },
                              icon: cartBloc.cartItems.length ==
                                      cartBloc.selectedCart.length
                                  ? Icon(Icons.check_box)
                                  : Icon(Icons.check_box_outline_blank)),
                          Text(
                            'Choose all',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartBloc.cartItems.length,
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        itemBuilder: (context, index) {
                          return CartProduct(
                            product: cartBloc.cartItems[index],
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                selectedCart.length > 0
                                    ? Colors.blue[900]
                                    : Colors.blue[900]!.withOpacity(0.5),
                              ),
                            ),
                            onPressed: selectedCart.length > 0
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return MultiBlocProvider(
                                            providers: [
                                              BlocProvider<CartBloc>.value(
                                                value: cartBloc,
                                              ),
                                              BlocProvider<UserBloc>.value(
                                                value: userBloc,
                                              ),
                                              BlocProvider<ProductBloc>.value(
                                                value: productBloc,
                                              ),
                                            ],
                                            child: ConfirmationScreen(),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                : null,
                            child: Text(
                              selectedCart.length > 0
                                  ? 'Checkout (${selectedCart.length})'
                                  : 'Checkout',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text('Your cart is empty'),
                );
        },
      ),
    );
  }
}
