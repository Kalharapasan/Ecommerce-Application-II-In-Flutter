import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'package:ecom_ii/core/models/user.dart' as app_user;
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SupabaseClient supabaseClient;
  late final StreamSubscription _authStateSubscription;

  AuthBloc({SupabaseClient? supabaseClient})
      : supabaseClient = supabaseClient ?? Supabase.instance.client,
        super(const AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthStateChanged>(_onAuthStateChanged);
    _authStateSubscription = this.supabaseClient.auth.onAuthStateChange.listen(
          (data) {
        final session = data.session;
        if (session != null) {
          add(AuthStateChanged(session: session));
        } else {
          add(AuthStateChanged(session: null));
        }
      },
    );
  }

}