import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Cubit<CartState> {
  CartBloc() : super(CartInitial());
}

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<dynamic> items;
  
  CartLoaded(this.items);
}