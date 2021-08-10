import 'package:dekornata_app_test/bloc/cart_bloc.dart';
import 'package:dekornata_app_test/bloc/product_bloc.dart';
import 'package:dekornata_app_test/bloc/user_bloc.dart';
import 'package:dekornata_app_test/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ProductBloc _productBloc = ProductBloc();
    final CartBloc _cartBloc = CartBloc();
    final UserBloc _userBloc = UserBloc();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(create: (context) => _productBloc),
          BlocProvider<CartBloc>(create: (context) => _cartBloc),
          BlocProvider<UserBloc>(create: (context) => _userBloc),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
