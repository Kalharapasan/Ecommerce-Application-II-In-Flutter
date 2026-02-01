import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ecom_ii/core/models/product.dart';
import 'package:ecom_ii/features/product/presentation/widgets/product_card.dart';
import 'package:ecom_ii/features/cart/presentation/providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> categories = [
    'All',
    'Action',
    'Adventure',
    'RPG',
    'Strategy',
    'Sports',
    'Racing',
  ];

  String selectedCategory = 'All';
  final List<Product> _products = [];

  Future<void> _loadProducts() async {
    setState(() {
      _products.addAll([
        Product(
          id: '1',
          name: 'Cyberpunk 2077',
          description: 'Open-world action RPG set in Night City',
          price: 59.99,
          category: 'RPG',
          images: ['https://picsum.photos/400/300?random=1'],
          rating: 4.5,
          reviewCount: 1200,
          isFeatured: true,
          createdAt: DateTime.now(),
        ),
        Product(
          id: '2',
          name: 'FIFA 24',
          description: 'Latest football simulation game',
          price: 69.99,
          category: 'Sports',
          images: ['https://picsum.photos/400/300?random=2'],
          rating: 4.3,
          reviewCount: 800,
          isFeatured: true,
          createdAt: DateTime.now(),
        ),
        Product(
          id: '3',
          name: 'Call of Duty: Modern Warfare',
          description: 'First-person shooter game',
          price: 49.99,
          category: 'Action',
          images: ['https://picsum.photos/400/300?random=3'],
          rating: 4.7,
          reviewCount: 2500,
          isFeatured: false,
          createdAt: DateTime.now(),
        ),
        Product(
          id: '4',
          name: 'The Witcher 3',
          description: 'Action RPG with rich storyline',
          price: 39.99,
          category: 'RPG',
          images: ['https://picsum.photos/400/300?random=4'],
          rating: 4.9,
          reviewCount: 3000,
          isFeatured: true,
          createdAt: DateTime.now(),
        ),
        Product(
          id: '5',
          name: 'Forza Horizon 5',
          description: 'Open-world racing game',
          price: 59.99,
          category: 'Racing',
          images: ['https://picsum.photos/400/300?random=5'],
          rating: 4.8,
          reviewCount: 1500,
          isFeatured: true,
          createdAt: DateTime.now(),
        ),
        Product(
          id: '6',
          name: 'Minecraft',
          description: 'Sandbox building game',
          price: 29.99,
          category: 'Adventure',
          images: ['https://picsum.photos/400/300?random=6'],
          rating: 4.6,
          reviewCount: 5000,
          isFeatured: false,
          createdAt: DateTime.now(),
        ),
      ]);
    });
  }


}