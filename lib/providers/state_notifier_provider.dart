import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/counter_state.dart';

// Define the StateNotifier for managing counter logic
class CounterNotifier extends StateNotifier<CounterState> {
  CounterNotifier() : super(CounterState(0));

  void increment() => state = CounterState(state.value + 1);
  void decrement() => state = CounterState(state.value - 1);
}

// StateNotifierProvider for counter management
final counterNotifierProvider = StateNotifierProvider<CounterNotifier, CounterState>((ref) {
  return CounterNotifier();
});
