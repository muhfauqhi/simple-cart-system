import 'dart:math';

import 'package:dekornata_app_test/bloc/cart_bloc.dart';
import 'package:dekornata_app_test/bloc/product_bloc.dart';
import 'package:dekornata_app_test/bloc/user_bloc.dart';
import 'package:dekornata_app_test/models/product.dart';
import 'package:dekornata_app_test/models/user.dart';
import 'package:dekornata_app_test/widgets/list_tile_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

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
        title: Text('Order Summary'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            cartBloc..add(CheckoutEvent(cartBloc.selectedCart));
            productBloc..add(ProductUpdateStockEvent(cartBloc.selectedCart));
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                late User user;
                if (state is UserLoadedState) {
                  user = state.user;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      generateInvoice(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Shipping Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.0),
                    Text('${user.name} (${user.phoneNum})'),
                    Text(
                      '${user.address}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cartBloc = BlocProvider.of<CartBloc>(context);
              List<Product> items = cartBloc.selectedCart;
              return Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ListTileProduct(items: items[index]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String generateInvoice() {
    DateTime now = DateTime.now();
    String day, month, year = '';
    Random random = Random();
    String sixDigitRandom = '';
    for (var i = 0; i < 6; i++) {
      sixDigitRandom = sixDigitRandom + random.nextInt(9).toString();
    }
    day = now.day.toString();
    month = now.month.toString();
    year = now.year.toString();
    if (day.length < 2) {
      day = '0' + day;
    }
    if (month.length < 2) {
      month = '0' + month;
    }
    return 'INVOICE/$year$month$day/DEKORNATA/$sixDigitRandom';
  }
}
