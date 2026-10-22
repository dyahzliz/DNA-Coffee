//NAMA : DYAH W SULISTYANINGTYAS
//NRP  : 162024002
//ISB 311 - SIS PRAKTIKUM

import 'package:flutter/material.dart';
import '../models/drink.dart';
import 'drink_detail_page.dart';

class HomePage extends StatefulWidget {
  final List<Drink> drinkList;
  final Function(Drink, int) onAddToCart;

  const HomePage({
    super.key,
    required this.drinkList,
    required this.onAddToCart,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = '';

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

  @override
  Widget build(BuildContext context) {
    final filteredDrinks = widget.drinkList.where((drink) {
      return drink.name.toLowerCase().contains(
            searchText.toLowerCase(),
          );
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Cari Minuman',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: filteredDrinks.isEmpty
              ? const Center(
                  child: Text('Minuman tidak ditemukan.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: filteredDrinks.length,
                  itemBuilder: (context, index) {
                    final drink = filteredDrinks[index];

                    return Card(
                      color: const Color(0xFFF0E2D3),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: Image.asset(
                          drink.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.local_cafe,
                            size: 40,
                          ),
                        ),
                        title: Text(
                          drink.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          _formatRupiah(drink.price),
                          style: const TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        trailing: Wrap(
                          spacing: 2,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DrinkDetailPage(
                                      drink: drink,
                                      onAddToCart: widget.onAddToCart,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Detail'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.onAddToCart(drink, 1);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6F4E37),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Pesan'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}