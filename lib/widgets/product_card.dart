import 'package:dekornata_app_test/bloc/cart_bloc.dart';
import 'package:dekornata_app_test/models/product.dart';
import 'package:dekornata_app_test/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return BlocProvider<CartBloc>.value(
                value: BlocProvider.of<CartBloc>(context),
                child: ProductDetailScreen(product: product),
              );
            },
          ),
        );
      },
      child: Card(
        elevation: 3.0,
        child: Column(
          children: [
            Image(
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
                product.image.first,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'IDR. ' + product.price.toStringAsFixed(0),
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          product.stock > 0
                              ? Colors.blue[900]
                              : Colors.blue[900]!.withOpacity(0.5),
                        ),
                      ),
                      child: Text(
                        'ADD TO CART',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: product.stock > 0
                          ? () => BlocProvider.of<CartBloc>(context)
                            ..add(AddCartEvent(product))
                          : null,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
