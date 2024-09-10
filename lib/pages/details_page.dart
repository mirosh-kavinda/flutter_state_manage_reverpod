import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../navigation/router_delegate.dart';

class DetailsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _handleBackButton() {
      final routerDelegate = Router.of(context).routerDelegate as MyRouterDelegate;
      routerDelegate.popRoute();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _handleBackButton,
        ),
        title: Text('Details Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Welcome to the Details Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}