import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple Provider
final helloWorldProvider = Provider<String>((ref) {
  return 'Hello, Riverpod!';
});

// StateProvider for Counter
final counterProvider = StateProvider<int>((ref) {
  return 0;
});


final showFetchValuesProvider = StateProvider<bool>((ref) => false);