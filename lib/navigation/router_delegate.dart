import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/home_page.dart';
import '../pages/details_page.dart';

final currentRouteProvider = StateProvider<String>((ref) {
  return '/';
});

class MyRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  final WidgetRef ref;

  MyRouterDelegate(this.ref) {
    ref.listen<String>(currentRouteProvider, (_, __) {
      notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    final route = ref.watch(currentRouteProvider);

    switch (route) {
      case '/':
        return HomePage();
      case '/details':
        return DetailsPage();
      default:
        return Scaffold(
          body: Center(
            child: Text('Unknown Route'),
          ),
        );
    }
  }

  @override
  Future<void> setNewRoutePath(Object configuration) async {
    if (configuration is String) {
      ref.read(currentRouteProvider.notifier).state = configuration;
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> popRoute() async {
    final currentRoute = ref.read(currentRouteProvider);
    if (currentRoute == '/details') {
      ref.read(currentRouteProvider.notifier).state = '/';
      return true;
    }
    return false;
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();
}