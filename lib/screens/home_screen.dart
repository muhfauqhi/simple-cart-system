import 'package:dekornata_app_test/bloc/cart_bloc.dart';
import 'package:dekornata_app_test/bloc/product_bloc.dart';
import 'package:dekornata_app_test/bloc/user_bloc.dart';
import 'package:dekornata_app_test/screens/cart_screen.dart';
import 'package:dekornata_app_test/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: Text('Dekornata App'),
        actions: [
          Stack(
            children: [
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
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
                            child: CartScreen(),
                          );
                        },
                      ),
                    );
                  }),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Positioned(
                    left: 5.0,
                    child: Text(
                      cartBloc.cartItems.length > 99
                          ? '99+'
                          : cartBloc.cartItems.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return GridView.builder(
            itemCount: productBloc.products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: productBloc.products[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
            ),
          );
        },
      ),
    );
  }
}
