// NAMA : DYAH W SULISTYANINGTYAS
// NRP  : 162024002
// ISB 311 - SIS PRAKTIKUM

import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../models/cart_item.dart';
import 'home_page.dart';
import 'cart_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<CartItem> _cartItems = [];

  final List<Drink> _drinkList = const [
    Drink(
      id: 'D001',
      name: 'Espresso',
      price: 18000,
      imageUrl: 'assets/espresso.png',
    ),
    Drink(
      id: 'D002',
      name: 'Americano',
      price: 20000,
      imageUrl: 'assets/americano.jpg',
    ),
    Drink(
      id: 'D003',
      name: 'Matcha Latte',
      price: 25000,
      imageUrl: 'assets/matchalatte.png',
    ),
    Drink(
      id: 'D004',
      name: 'Chocolate Frappe',
      price: 28000,
      imageUrl: 'assets/chocolatefrappe.jpg',
    ),
  ];

  // Menambahkan minuman ke keranjang.
  void _addToCart(Drink drink, int quantity) {
    if (quantity <= 0) return;

    setState(() {
      final index = _cartItems.indexWhere(
        (item) => item.drink.id == drink.id,
      );

      if (index >= 0) {
        _cartItems[index].quantity += quantity;
      } else {
        _cartItems.add(
          CartItem(
            drink: drink,
            quantity: quantity,
          ),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${drink.name} ditambahkan ke keranjang.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Menghapus minuman dari keranjang.
  void _removeFromCart(String drinkId) {
    setState(() {
      _cartItems.removeWhere(
        (item) => item.drink.id == drinkId,
      );
    });
  }

  // Mengubah angka menjadi format Rupiah.
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

  void _checkout(String namaPemesan, int nomorMeja) {
    if (_cartItems.isEmpty) return;

    final total = _cartItems.fold<int>(
      0,
      (sum, item) => sum + item.drink.price * item.quantity,
    );

    final totalItems = _cartItems.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 48,
        ),
        title: const Text('Checkout Berhasil!'),
        content: Text(
          'Terima kasih telah memesan di DnA Coffee.\n\n'
          'Nama pemesan: $namaPemesan\n'
          'Nomor meja: $nomorMeja\n'
          'Jumlah minuman: $totalItems\n'
          'Total pembayaran: ${_formatRupiah(total)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              setState(() {
                _cartItems.clear();
                _selectedIndex = 0;
              });
            },
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'DnA Coffee - Menu'
              : 'Keranjang Anda',
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(
            drinkList: _drinkList,
            onAddToCart: _addToCart,
          ),
          CartPage(
            cartItems: _cartItems,
            onRemoveFromCart: _removeFromCart,
            onCheckout: _checkout,
            formatRupiah: _formatRupiah,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF6F4E37),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}
