//NAMA : DYAH W SULISTYANINGTYAS
//NRP  : 162024002
//ISB 311 - SIS PRAKTIKUM

import 'package:flutter/material.dart';
import '../models/drink.dart';

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;
  final Function(Drink, int) onAddToCart;

  const DrinkDetailPage({
    super.key,
    required this.drink,
    required this.onAddToCart,
  });

  @override
  State<DrinkDetailPage> createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  int _quantity = 1;

  String _formatRupiah(int amount) {
    final digits = amount.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);

      final remaining = digits.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }

    return 'Rp $buffer';
  }

  void _addOrder() {
    widget.onAddToCart(widget.drink, _quantity);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 42,
        ),
        title: const Text('Berhasil Ditambahkan'),
        content: Text(
          '${widget.drink.name} sebanyak $_quantity '
          'berhasil ditambahkan ke keranjang.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drink.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.drink.imageUrl,
              width: 180,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.local_cafe,
                size: 140,
                color: Color(0xFF6F4E37),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.drink.name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _formatRupiah(widget.drink.price),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            const Text('Jumlah Pesanan'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (_quantity > 1) {
                      setState(() {
                        _quantity--;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '$_quantity',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Subtotal: '
              '${_formatRupiah(widget.drink.price * _quantity)}',
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addOrder,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Tambah ke Keranjang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F4E37),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}