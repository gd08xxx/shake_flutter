import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'dart:math';

class HomeProvider extends ChangeNotifier {
  int _currentIndex = 0;
  double _angle = -math.pi/2; // 🔄 rotation angle

  int get currentIndex => _currentIndex;
  double get angle => _angle;

final List<Map<String, dynamic>> items = [
 
  {
    'name': 'Orange Zest',
    'image': 'assets/orng.png', // ← orange wali image lagao
    'bgimage': 'assets/b.png',
    'desc': 'Bright, tangy, and packed with Vitamin C goodness.',
    'backgroundColor': Color(0xFFFDE8D0), // Soft peach/cream (orange tone)
    'containerColor': Color.fromARGB(255, 190, 102, 1), // Orange
  },
  {
    'name': 'Avocado Glow',
    'image': 'assets/grn.png', // ← avocado wali image lagao
    'bgimage': 'assets/av.png',
    'desc': 'Creamy, smooth, and full of healthy fats for lasting energy.',
    'backgroundColor': Color(0xFFE8F5E8), // Light mint/sage
    'containerColor': Color.fromARGB(255, 14, 94, 25), // Dark green (avocado peel)
  },
  {
    'name': 'Mango Sunrise',
    'image': 'assets/yello.png', // ← mango wali image lagao
    'bgimage': 'assets/a.png',
    'desc': 'Sweet, tropical, and golden — the king of fruits in a glass.',
    'backgroundColor': Color(0xFFFFF8E1), // Warm cream
    'containerColor': Color.fromARGB(255, 194, 149, 2), // Bright mango yellow
  },
   {
    'name': 'Watermelon Splash',
    'image': 'assets/red.png', // ← watermelon wali image lagao
    'bgimage': 'assets/d.png',
    'desc': 'Juicy, refreshing, and hydrating — the ultimate summer cooler.',
    'backgroundColor': Color(0xFFD4A5A5), // Light burgundy/rose (watermelon vibes)
    'containerColor': Color.fromARGB(255, 90, 20, 43), // Dark burgundy
  },
];


  void nextItem() {
    _currentIndex = (_currentIndex + 1) % items.length;
    _angle -= (2 * pi / items.length); // ✅ circular rotation step
    notifyListeners();
  }
void previousItem() {
  _currentIndex = (_currentIndex - 1 + items.length) % items.length;
  _angle += (2 * pi / items.length);
  notifyListeners();
}
  Map<String, dynamic> getCurrentItem() {
    return items[_currentIndex];
  }

  String getCurrentBackgroundImage() {
    return items[_currentIndex]['bgimage'] as String;
  }

  Color getCurrentBackgroundColor() {
    return items[_currentIndex]['backgroundColor'] as Color;
  }

  Color getCurrentContainerColor() {
    return items[_currentIndex]['containerColor'] as Color;
  }
}