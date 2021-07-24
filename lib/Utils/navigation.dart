import 'package:flutter/material.dart';

GlobalKey<NavigatorState>? navigationKey = GlobalKey<NavigatorState>();

class NavigationService {
  static NavigationService instance = NavigationService();

  Future<dynamic> navigateToReplacement(String _rn) {
    return navigationKey!.currentState!.pushReplacementNamed(_rn);
  }

  Future<dynamic> navigateTo(String _rn) {
    return navigationKey!.currentState!.pushNamed(_rn);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute _rn) {
    return navigationKey!.currentState!.push(_rn);
  }

  Future<dynamic> navigateToPushAndRemoveUntilRoute(String _rn) {
    return navigationKey!.currentState!
        .pushNamedAndRemoveUntil(_rn, (route) => false);
  }

  goback() {
    return navigationKey!.currentState!.pop();
  }
}
