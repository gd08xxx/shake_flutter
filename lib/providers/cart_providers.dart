// Cart Provider for state management
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  
  List<CartItem> get cartItems => _cartItems;
  
  int get cartCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  
  void addToCart(CartItem item) {
    // Check if item with same name and size already exists
    int existingIndex = _cartItems.indexWhere(
      (cartItem) => cartItem.name == item.name && cartItem.size == item.size,
    );
    
    if (existingIndex != -1) {
      // Update quantity if item exists
      _cartItems[existingIndex].quantity += item.quantity;
    } else {
      // Add new item
      _cartItems.add(item);
    }
    notifyListeners();
  }
  
  void removeFromCart(String name, String size) {
    _cartItems.removeWhere(
      (item) => item.name == name && item.size == size,
    );
    notifyListeners();
  }
  
  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}

// Cart Item Model
class CartItem {
  final String name;
  final String image;
  final String size;
  int quantity;
  final double price;
  
  CartItem({
    required this.name,
    required this.image,
    required this.size,
    required this.quantity,
    required this.price,
  });
}
