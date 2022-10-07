import 'dart:async';

import 'package:flutter/widgets.dart';

import 'data.dart';

/// A scope that provides [StreamAuth] for the subtree.
class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  /// Creates a [StreamAuthScope] sign in scope.
  StreamAuthScope({
    Key? key,
    required Widget child,
  }) : super(
    key: key,
    notifier: StreamAuthNotifier(),
    child: child,
  );

  /// Gets the [StreamAuth].
  static StreamAuth of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StreamAuthScope>()!
        .notifier!
        .streamAuth;
  }
}

/// A class that converts [StreamAuth] into a [ChangeNotifier].
class StreamAuthNotifier extends ChangeNotifier {
  /// Creates a [StreamAuthNotifier].
  StreamAuthNotifier() : streamAuth = StreamAuth() {
    streamAuth.onCurrentUserChanged.listen((User? string) {
      notifyListeners();
    });
  }

  /// The stream auth client.
  final StreamAuth streamAuth;
}

/// An asynchronous log in services mock with stream similar to google_sign_in.
///
/// This class adds an artificial delay of 3 second when logging in an user, and
/// will automatically clear the login session after [refreshInterval].
class StreamAuth {
  /// Creates an [StreamAuth] that clear the current user session in
  /// [refeshInterval] second.
  StreamAuth({this.refreshInterval = 20})
      : _userStreamController = StreamController<User?>.broadcast() {
    _userStreamController.stream.listen((User? currentUser) {
      _currentUser = currentUser;
    });
  }

  /// The current user.
  User? get currentUser => _currentUser;
  User? _currentUser = const User(id: "0", firstName: 'Chun-Heng', lastName: 'Tai', email: 'chtai@google.com');

  /// Checks whether current user is signed in with an artificial delay to mimic
  /// async operation.
  Future<bool> isSignedIn() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return _currentUser != null;
  }

  /// A stream that notifies when current user has changed.
  Stream<User?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<User?> _userStreamController;

  /// The interval that automatically signs out the user.
  final int refreshInterval;

  Timer? _timer;
  Timer _createRefreshTimer() {
    return Timer(Duration(seconds: refreshInterval), () {
      _userStreamController.add(null);
      _timer = null;
    });
  }

  /// Signs in a user with an artificial delay to mimic async operation.
  Future<void> signIn(User user) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    _userStreamController.add(user);
    _timer?.cancel();
    _timer = _createRefreshTimer();
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    _timer?.cancel();
    _timer = null;
    _userStreamController.add(null);
  }
}