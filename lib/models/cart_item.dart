//NAMA : DYAH W SULISTYANINGTYAS
//NRP  : 162024002
//ISB 311 - SIS PRAKTIKUM

import 'drink.dart';

class CartItem {
  final Drink drink;
  int quantity;

  CartItem({
    required this.drink,
    this.quantity = 1,
  });
}