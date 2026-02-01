import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom_ii/features/cart/presentation/providers/cart_provider.dart';
import 'package:ecom_ii/shared/widgets/custom_text_field.dart';
import 'package:ecom_ii/shared/widgets/primary_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  String _selectedPaymentMethod = 'credit_card';


}