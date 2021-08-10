import 'package:dekornata_app_test/models/product.dart';
import 'package:flutter/material.dart';

class ListTileProduct extends StatelessWidget {
  const ListTileProduct({Key? key, required this.items}) : super(key: key);

  final Product items;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  items.image.first,
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items.name.split('/').first + items.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'IDR ' + items.price.toStringAsFixed(0),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                        fontSize: 13.0),
                  ),
                  Text(
                    items.quantity.toString() +
                        ' item (${(items.weight * items.quantity).toStringAsFixed(0)} gr)',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 13.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
