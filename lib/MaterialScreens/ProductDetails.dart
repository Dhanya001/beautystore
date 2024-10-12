import 'dart:convert';

import 'package:flutter/material.dart';


class Productdetail extends StatefulWidget {
  final id;
  Productdetail(this.id);

  @override
  State<Productdetail> createState() => _ProductdetailState();
}

class _ProductdetailState extends State<Productdetail> {
  bool isFavorite = false;
  Map _products={};
  int _cartCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showPayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pay Now'),
          content: Text('Please pay \$${_products['price'] ?? ''}'),
          actions: [
            TextButton(
              child: Text('Pay'),
              onPressed: () {
                // Add logic to handle payment
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        title: Text(_products['title'] ?? 'Loading...'),
      ),*/
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Product Details")),

        ],
      ),
    );
  }
}