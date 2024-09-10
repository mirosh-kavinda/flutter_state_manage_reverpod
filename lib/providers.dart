// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider<String>((ref) {
  return 'Hello, Riverpod!';
});

final counterProvider = StateProvider<int>((ref) {
  return 0;
});

final fetchDataProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 2));
  return 'Fetched Data';
});
