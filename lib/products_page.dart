
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'product_widgets.dart';

class ProductsPage extends StatefulWidget {
  final String username;

  const ProductsPage({
    super.key,
    required this.username,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int favorites = 0;
  double screenWidth = 0;
  String cartMessage = '';

  final List<Map<String, dynamic>> products = [
    {'name': 'Laptop', 'price': 1200},
    {'name': 'Phone', 'price': 800},
    {'name': 'Headphones', 'price': 150},
    {'name': 'Keyboard', 'price': 100},
    {'name': 'Mouse', 'price': 50},
    {'name': 'Monitor', 'price': 400},
    {'name': 'Tablet', 'price': 600},
    {'name': 'Smart Watch', 'price': 250},
  ];

  @override
  void initState() {
    super.initState();
    print("ProductsPage: initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final size = MediaQuery.sizeOf(context);
    screenWidth = size.width;

    print(
      "ProductsPage: didChangeDependencies "
          "-> width: ${size.width}, height: ${size.height}",
    );
  }

  @override
  Widget build(BuildContext context) {
    print("ProductsPage: build");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${widget.username}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Favorites: $favorites'),
                Text(
                  'Screen width: ${screenWidth.toStringAsFixed(1)}',
                ),
                if (cartMessage.isNotEmpty)
                  Text(
                    cartMessage,
                    style: const TextStyle(color: Colors.green),
                  ),
              ],
            ),
          ),
          Expanded(
            child: screenWidth < 600
                ? ProductsListView(
              products: products,
              onFavoritePressed: () {
                setState(() {
                  favorites++;
                });
              },
              onProductTap: (index) async {
                final product = products[index];

                final result = await context.push<String>(
                  '/details/${Uri.encodeComponent(product['name'].toString())}/${product['price']}',
                );

                if (!mounted) return;

                if (result != null) {
                  setState(() {
                    cartMessage = result;
                  });
                }
              },
            )
                : ProductsGridView(
              products: products,
              onFavoritePressed: () {
                setState(() {
                  favorites++;
                });
              },
              onProductTap: (index) async {
                final product = products[index];

                final result = await context.push<String>(
                  '/details/${Uri.encodeComponent(product['name'].toString())}/${product['price']}',
                );

                if (!mounted) return;

                if (result != null) {
                  setState(() {
                    cartMessage = result;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    print("ProductsPage: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("ProductsPage: dispose");
    super.dispose();
  }
}
