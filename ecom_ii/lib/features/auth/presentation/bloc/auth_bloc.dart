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

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final session = supabaseClient.auth.currentSession;
      if (session != null) {
        final user = await _getUserProfile(session.user.id);
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      
      if (response.user != null) {
        final user = await _getUserProfile(response.user!.id);
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } on AuthException catch (e) {
      String errorMessage = e.message;
      if (e.message.toLowerCase().contains('email rate limit')) {
        errorMessage = 'Too many login attempts. Please wait a few minutes before trying again.';
      } else if (e.message.toLowerCase().contains('rate limit')) {
        errorMessage = 'Too many attempts. Please wait a few minutes before trying again.';
      } else if (e.message.toLowerCase().contains('invalid login')) {
        errorMessage = 'Invalid email or password. Please check your credentials.';
      } else if (e.message.toLowerCase().contains('email not confirmed')) {
        errorMessage = 'Please check your email and click the confirmation link.';
      }
      
      emit(AuthError(message: errorMessage));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final response = await supabaseClient.auth.signUp(
        email: event.email,
        password: event.password,
        data: {
          'name': event.name,
        },
      );
      
      if (response.user != null) {
        await supabaseClient.from('profiles').insert({
          'id': response.user!.id,
          'email': event.email,
          'name': event.name,
          'created_at': DateTime.now().toIso8601String(),
        });
        
        final user = await _getUserProfile(response.user!.id);
        emit(AuthAuthenticated(user: user));
      }
     } on AuthException catch (e) {
      String errorMessage = e.message;
      if (e.message.toLowerCase().contains('email rate limit')) {
        errorMessage = 'Too many registration attempts. Please wait a few minutes before trying again.';
      } else if (e.message.toLowerCase().contains('rate limit')) {
        errorMessage = 'Too many attempts. Please wait a few minutes before trying again.';
      } else if (e.message.toLowerCase().contains('already registered')) {
        errorMessage = 'This email is already registered. Please try logging in instead.';
      } else if (e.message.toLowerCase().contains('invalid email')) {
        errorMessage = 'Please enter a valid email address.';
      } else if (e.message.toLowerCase().contains('password')) {
        errorMessage = 'Password must be at least 6 characters long.';
      }
      
      emit(AuthError(message: errorMessage));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await supabaseClient.auth.signOut();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void _onAuthStateChanged(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) {
    if (event.session == null) {
      emit(const AuthUnauthenticated());
    } else {
    }
  }

  Future<app_user.User> _getUserProfile(String userId) async {
    final response = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    
    return app_user.User.fromJson(response);
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }

}