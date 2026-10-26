
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  final int price;

  const DetailsPage({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    print("DetailsPage: initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("DetailsPage: didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("DetailsPage: build");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Price: \$${widget.price}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  context.pop(
                    '${widget.name} added to cart',
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("DetailsPage: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("DetailsPage: dispose");
    super.dispose();
  }
}
