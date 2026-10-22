// NAMA : DYAH W SULISTYANINGTYAS
// NRP  : 162024002
// ISB 311 - SIS PRAKTIKUM

import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;
  final Function(String, int) onCheckout;
  final String Function(int) formatRupiah;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onCheckout,
    required this.formatRupiah,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _mejaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _mejaController.dispose();
    super.dispose();
  }

  void _prosesCheckout() {
    if (widget.cartItems.isEmpty) return;

    if (!_formKey.currentState!.validate()) return;

    final namaPemesan = _namaController.text.trim();
    final nomorMeja = int.tryParse(_mejaController.text.trim());

    if (nomorMeja == null) return;

    FocusScope.of(context).unfocus();

    widget.onCheckout(namaPemesan, nomorMeja);
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.cartItems.fold<int>(
      0,
      (sum, item) => sum + item.drink.price * item.quantity,
    );

    final totalItems = widget.cartItems.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    return Column(
      children: [
        Expanded(
          child: widget.cartItems.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 85,
                        color: Colors.brown,
                      ),
                      SizedBox(height: 16),
                      Text('Keranjang Anda masih kosong.'),
                      SizedBox(height: 6),
                      Text('Yuk, pilih kopi favoritmu!'),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartItems[index];
                    final subtotal =
                        item.drink.price * item.quantity;

                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item.drink.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                width: 60,
                                height: 60,
                                child: Icon(
                                  Icons.local_cafe,
                                  size: 40,
                                  color: Color(0xFF6F4E37),
                                ),
                              );
                            },
                          ),
                        ),
                        title: Text(
                          item.drink.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${item.quantity} x '
                          '${widget.formatRupiah(item.drink.price)}\n'
                          'Subtotal: ${widget.formatRupiah(subtotal)}',
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          tooltip: 'Hapus dari keranjang',
                          onPressed: () {
                            widget.onRemoveFromCart(item.drink.id);
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFFF0E2D3),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Jumlah item'),
                    Text('$totalItems minuman'),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.formatRupiah(totalPrice),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6F4E37),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _namaController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Nama Pemesan',
                    hintText: 'Masukkan nama pemesan',
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama pemesan wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: _mejaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nomor Meja',
                    hintText: 'Contoh: 5',
                    prefixIcon: const Icon(Icons.table_restaurant),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nomor meja wajib diisi';
                    }

                    final nomor = int.tryParse(value.trim());

                    if (nomor == null || nomor <= 0) {
                      return 'Masukkan nomor meja yang valid';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: widget.cartItems.isEmpty
                        ? null
                        : _prosesCheckout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6F4E37),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Checkout Sekarang',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
