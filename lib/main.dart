
/*
PART 1 - LIFECYCLE ANSWERS

a) When a page opens for the first time:
   initState() -> didChangeDependencies() -> build()
   The exact sequence can include additional build calls.

b) After pressing the heart button:
   setState() causes build() to run again.
   initState() does not run again for the same State.

c) When leaving a page and going back:
   The old page may run deactivate() and dispose() if removed
   permanently. With push/pop, the previous page usually stays
   mounted while the details page is open, then becomes visible
   again when the details page is popped. build() may run again.

d) When resizing the browser:
   MediaQuery-dependent widgets rebuild because the screen size
   changes. didChangeDependencies() runs again when the MediaQuery
   dependency changes. The Products page updates screenWidth and
   switches between list and grid.

PART 4 - SHORT ANSWERS

1) context.go replaces the current navigation location.
   Example: Login -> Products using context.goNamed('products').

   context.push adds a page to the navigation stack and can return
   a result.
   Example: Products -> Details using context.push<String>(...).

2) We use go for Login -> Products because we want to navigate to
   the products destination. We use push for Product -> Details
   because we want to open details on top of Products and return
   a result when Details is closed.

3) A path parameter is part of the URL path:
   /details/Laptop/1200
   Here, Laptop is the name and 1200 is the price.

   A query parameter comes after ?:
   /products?user=Guest
   Here, user is the query parameter and Guest is its value.

NAVIGATOR VERSION - KEPT AS COMMENTS (PART 2)

Login -> Products with pushNamed and arguments:

// Navigator.pushNamed(
//   context,
//   '/products',
//   arguments: 'Guest',
// );

Products route argument extraction:

// GoRoute is NOT used for this Navigator version.
// In MaterialApp routes, use:
// '/products': (context) {
//   final username =
//       ModalRoute.of(context)!.settings.arguments as String;
//   return ProductsPage(username: username);
// },

Products -> Details with push and constructor arguments:

// final result = await Navigator.push<String>(
//   context,
//   MaterialPageRoute(
//     builder: (_) => DetailsPage(
//       name: product['name'].toString(),
//       price: product['price'] as int,
//     ),
//   ),
// );

Details -> Products result:

// Navigator.pop(context, 'Laptop added to cart');

// In the Navigator version, use MaterialApp(routes: {...})
// instead of MaterialApp.router, and use Navigator APIs instead
// of GoRouter APIs. The active app below uses go_router.
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login_page.dart';
import 'products_page.dart';
import 'details_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) {
        final username = state.uri.queryParameters['user'] ?? 'Guest';

        return ProductsPage(username: username);
      },
    ),
    GoRoute(
      path: '/details/:name/:price',
      name: 'details',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final price = int.parse(state.pathParameters['price']!);

        return DetailsPage(
          name: name,
          price: price,
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mini Product Catalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
