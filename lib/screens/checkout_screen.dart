import 'package:flutter/material.dart';
import '../models/product.dart';
import 'success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> cart;

  const CheckoutScreen({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  int selectedMethod = 1;
  bool saveCard = true;

  double get total =>
      widget.cart.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {

    const Color bgColor = Color(0xFFF5F6FA);
    const Color primaryBlue = Color(0xFF4A80F0);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Payment data",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            const Text("Total price",
                style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 5),

            Text(
              "\$${total.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),

            const SizedBox(height: 30),

            const Text("Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 15),

            Row(
              children: [
                _paymentPill("PayPal", 0),
                const SizedBox(width: 10),
                _paymentPill("Credit", 1),
                const SizedBox(width: 10),
                _paymentPill("Wallet", 2),
              ],
            ),

            const SizedBox(height: 30),

            _inputCard("Card number"),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: _inputCard("Month / Year")),
                const SizedBox(width: 10),
                Expanded(child: _inputCard("CVV")),
              ],
            ),

            const SizedBox(height: 20),

            _inputCard("Your name and surname"),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Save card data"),
                Switch(
                  value: saveCard,
                  activeColor: primaryBlue,
                  onChanged: (val) => setState(() => saveCard = val),
                )
              ],
            ),

            const SizedBox(height: 40),

            _confirmButton(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _paymentPill(String text, int index) {
    bool active = selectedMethod == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedMethod = index),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            gradient: active
                ? const LinearGradient(
                    colors: [Color(0xFF4A80F0), Color(0xFF6A9BFF)],
                  )
                : null,
            color: active ? null : const Color(0xFFE8ECF5),
            borderRadius: BorderRadius.circular(16),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: const Color(0xFF4A80F0).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    )
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: active ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputCard(String hint) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }

  Widget _confirmButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A80F0), Color(0xFF6A9BFF)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const SuccessScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          "Proceed to confirm",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}