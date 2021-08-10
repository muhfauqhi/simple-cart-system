import 'package:dekornata_app_test/bloc/cart_bloc.dart';
import 'package:dekornata_app_test/bloc/product_bloc.dart';
import 'package:dekornata_app_test/bloc/user_bloc.dart';
import 'package:dekornata_app_test/models/product.dart';
import 'package:dekornata_app_test/models/user.dart';
import 'package:dekornata_app_test/screens/invoice_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

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
        title: Text('Confirmation Order'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            height: 75.0,
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
              List<Product> products = cartBloc.selectedCart;
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 3.0,
                    child: Container(
                      height: 120.0,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Image(
                              height: 100.0,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loading) {
                                if (loading == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                              image: NetworkImage(
                                products[index].image.first,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].name.split('/').first +
                                      products[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'IDR ' +
                                      products[index].price.toStringAsFixed(0),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900],
                                      fontSize: 13.0),
                                ),
                                Text(
                                  products[index].quantity.toString() +
                                      ' item (${(products[index].weight * products[index].quantity).toStringAsFixed(0)} gr)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total amount'),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return Text(
                          calculateTotalAmount(cartBloc.selectedCart),
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue[900]),
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (_) {
                          return CupertinoAlertDialog(
                            title: Text('Confirm Order'),
                            content: Text(
                              'Please make sure all cart items you selected and your shipping information are correct before proccess to further',
                            ),
                            actions: [
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                isDestructiveAction: true,
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) {
                                      return MultiBlocProvider(
                                        providers: [
                                          BlocProvider<UserBloc>.value(
                                            value: userBloc,
                                          ),
                                          BlocProvider<CartBloc>.value(
                                            value: cartBloc,
                                          ),
                                          BlocProvider<ProductBloc>.value(
                                            value: productBloc,
                                          ),
                                        ],
                                        child: InvoiceScreen(),
                                      );
                                    }),
                                  );
                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text(
                    'Pay',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String calculateTotalAmount(List<Product> list) {
    double res = 0;

    list.forEach((product) {
      res = res + product.price * product.quantity;
    });

    return 'IDR. ' + res.toStringAsFixed(0);
  }
}
