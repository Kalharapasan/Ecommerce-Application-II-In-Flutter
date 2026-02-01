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

  List<Product> get filteredProducts {
    if (selectedCategory == 'All') {
      return _products;
    }
    return _products.where((p) => p.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Shop'),
        actions: [
          IconButton(
            icon: Badge(
              label: Text(cartProvider.itemCount.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () => context.go('/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search games...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(
                  product: product,
                  onTap: () => context.go('/products/${product.id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}