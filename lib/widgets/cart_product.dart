import 'package:dekornata_app_test/bloc/cart_bloc.dart';
import 'package:dekornata_app_test/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProduct extends StatefulWidget {
  final Product product;
  const CartProduct({Key? key, required this.product}) : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Card(
          elevation: 3.0,
          child: Container(
            height: 120.0,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                IconButton(
                  iconSize: 20.0,
                  onPressed: () {
                    cartBloc..add(SelectCartEvent(widget.product));
                  },
                  icon: cartBloc.selectedCart.contains(widget.product)
                      ? Icon(Icons.check_box)
                      : Icon(Icons.check_box_outline_blank),
                ),
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
                      widget.product.image.first,
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name.split('/').first +
                            widget.product.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'IDR ' + widget.product.price.toStringAsFixed(0),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                            fontSize: 13.0),
                      ),
                      Text(
                        widget.product.stock.toString() + ' available',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 13.0),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              iconSize: 20.0,
                              onPressed: () {
                                cartBloc..add(RemoveCartEvent(widget.product));
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.grey[900],
                              ),
                            ),
                            IconButton(
                              iconSize: 18.0,
                              // onPressed: widget.product.quantity > 1
                              //     ? () {
                              //         setState(() {
                              //           widget.product.quantity--;
                              //         });
                              //       }
                              //     : null,
                              onPressed: widget.product.quantity > 1
                                  ? () {
                                      cartBloc
                                        ..add(SubtractingCartEvent(
                                            widget.product));
                                    }
                                  : null,
                              icon: Icon(
                                Icons.remove,
                              ),
                            ),
                            Text(widget.product.quantity.toString()),
                            IconButton(
                              iconSize: 18.0,
                              onPressed:
                                  widget.product.quantity < widget.product.stock
                                      ? () {
                                          cartBloc
                                            ..add(AddCartEvent(widget.product));
                                        }
                                      : null,
                              icon: Icon(
                                Icons.add,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
