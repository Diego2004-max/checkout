import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'checkout_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  final List<Product> products = [
    Product(name: "Nike Air Max", price: 120000),
    Product(name: "Adidas Ultraboost", price: 210000),
    Product(name: "Puma Runner", price: 190000),
  ];

  final List<Product> cart = [];

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  double get total =>
      cart.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Products", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckoutScreen(cart: cart),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
              onAdd: () => addToCart(products[index]),
            );
          },
        ),
      ),
      floatingActionButton: cart.isNotEmpty
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFF4A80F0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(cart: cart),
                  ),
                );
              },
              label: Text("Checkout \$${total.toStringAsFixed(0)}"),
            )
          : null,
    );
  }
}