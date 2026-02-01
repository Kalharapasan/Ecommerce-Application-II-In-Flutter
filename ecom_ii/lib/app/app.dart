import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ecom_ii/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecom_ii/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecom_ii/features/auth/presentation/screens/splash_screen.dart';
import 'package:ecom_ii/features/auth/presentation/screens/login_screen.dart';
import 'package:ecom_ii/features/auth/presentation/screens/register_screen.dart';
import 'package:ecom_ii/features/product/presentation/screens/home_screen.dart';
import 'package:ecom_ii/features/product/presentation/screens/product_detail_screen.dart';
import 'package:ecom_ii/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecom_ii/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecom_ii/features/cart/presentation/providers/cart_provider.dart';
import 'package:ecom_ii/features/order/presentation/screens/orders_screen.dart';
import 'package:ecom_ii/features/order/presentation/screens/checkout_screen.dart';
import 'package:ecom_ii/features/auth/presentation/screens/profile_screen.dart';

class App extends StatelessWidget {
  App({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/products/:id',
        builder: (context, state) => ProductDetailScreen(
          productId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
    ],
    redirect: (context, state) {
      if (state.uri.path == '/') {
        return null;
      }
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc()..add(AppStarted()),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(),
          ),
        ],
        child: MaterialApp.router(
          title: 'Game Shop',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: 'Inter',
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: true,
            ),
          ),
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}