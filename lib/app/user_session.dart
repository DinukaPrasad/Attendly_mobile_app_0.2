import '../models/user_models.dart';

/// Lightweight singleton that holds the currently logged-in user.
///
/// Populated after login via [UserRepository.fetchCurrentUser] and
/// cleared on logout. Screens read [currentUser] for display name,
/// role, avatar, etc.
class UserSession {
  UserSession._();

  static ApiUser? _currentUser;

  /// The authenticated user, or `null` if not logged in.
  static ApiUser? get currentUser => _currentUser;

  /// Whether a user is currently logged in.
  static bool get isLoggedIn => _currentUser != null;

  /// Stores the user after a successful login + profile fetch.
  static void setUser(ApiUser user) {
    _currentUser = user;
  }

  /// Clears the session (called on logout).
  static void clear() {
    _currentUser = null;
  }

  /// Convenience: returns the user's first name, or 'User' as fallback.
  static String get firstName {
    final name = _currentUser?.fullName ?? '';
    return name.split(' ').first.isNotEmpty ? name.split(' ').first : 'User';
  }

  /// Convenience: returns the user's full name, or 'User' as fallback.
  static String get fullName => _currentUser?.fullName ?? 'User';

  /// Convenience: returns the user's role (uppercase), or empty string.
  static String get role => _currentUser?.role.toUpperCase() ?? '';
}
