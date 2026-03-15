import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/user.dart';

class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  final User? user;
  final bool isLoading;
  final String? errorMessage;

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState());

  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final hasValidCredentials =
        email.trim().toLowerCase() == 'inspector@hotel.com' &&
        password == 'password123';

    if (!hasValidCredentials) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid credentials. Try inspector@hotel.com / password123',
      );
      return false;
    }

    state = AuthState(
      user: User(id: 'inspector-001', email: email.trim(), displayName: 'Alex Inspector'),
      isLoading: false,
    );
    return true;
  }

  void logout() {
    state = const AuthState();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController();
});
