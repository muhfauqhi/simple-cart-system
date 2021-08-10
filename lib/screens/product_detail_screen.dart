import 'package:dekornata_app_test/bloc/cart_bloc.dart';
import 'package:dekornata_app_test/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _currentPageView = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.blue[900],
        toolbarHeight: 100.0,
        centerTitle: true,
        title: Text(widget.product.name),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _currentPageView = index;
                  });
                },
                controller: PageController(initialPage: 0),
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.image.length,
                itemBuilder: (context, index) => Image(
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
                    widget.product.image[index],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < widget.product.image.length; i++)
                    if (i == _currentPageView)
                      _slideDots(true)
                    else
                      _slideDots(false)
                ],
              ),
            ),
            Container(
              height: 150.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      color: Colors.blue[900],
                    ),
                  ),
                  Text(
                    'IDR ' + widget.product.price.toStringAsFixed(0),
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Stock ' + widget.product.stock.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blue[900],
                tabs: [
                  Tab(
                    child: Text(
                      'DESCRIPTIONS',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'DESCRIPTIONS',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    child: Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        _rowInformation(
                          'Weight',
                          _convertWeight(widget.product.weight),
                        ),
                        Divider(color: Colors.amber),
                        _rowInformation('Material', widget.product.material),
                        Divider(color: Colors.amber),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            widget.product.stock > 0
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
        onPressed: widget.product.stock > 0
            ? () =>
                BlocProvider.of<CartBloc>(context)..add(AddCartEvent(widget.product))
            : null,
      ),
    );
  }

  Widget _rowInformation(String informationText, String value) {
    return Container(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            informationText,
            style: TextStyle(
              color: Colors.blue[900],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.blue[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _slideDots(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey[400] : Colors.white70,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  String _convertWeight(double weight) {
    return (weight / 1000).toStringAsFixed(2) + ' kilogram';
  }
}
