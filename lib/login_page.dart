
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    print("LoginPage: initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("LoginPage: didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("LoginPage: build");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini Product Catalog"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text("Explore our products"),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                context.goNamed(
                  'products',
                  queryParameters: {'user': 'Guest'},
                );
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("LoginPage: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("LoginPage: dispose");
    super.dispose();
  }
}
