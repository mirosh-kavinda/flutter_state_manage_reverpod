import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/navigation/router_delegate.dart';
import '../providers/simple_provider.dart';
import '../providers/state_notifier_provider.dart';
import '../providers/repository_provider.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accessing simple provider
    final message = ref.watch(helloWorldProvider);


    // Accessing state notifier provider
    final counterState = ref.watch(counterNotifierProvider);

    // Accessing repository data provider
    final asyncRepositoryData = ref.watch(repositoryDataProvider);

    // Accessing showFetchValues state
    final showFetchValues = ref.watch(showFetchValuesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Test App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simple Provider
            Text(message, style: TextStyle(fontSize: 24)),

            SizedBox(height: 20),

            // StateNotifierProvider
            Text('Counter: ${counterState.value}', style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).decrement();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    ref.read(counterNotifierProvider.notifier).increment();
                  },
                ),
                
              ],
            ),
 Center(
        child: ElevatedButton(
          onPressed: () {
              ref.read(currentRouteProvider.notifier).state = '/details';
          },
          child: Text('Go to Details Page'),
        ),),
           

         Center(
        child: ElevatedButton(
          onPressed: () {
          ref.read(showFetchValuesProvider.notifier).state = !showFetchValues;
          },
          child: Text('Fetch Data from Repo'),
        ),),   // FutureProvider for repository

             // FutureProvider for repository
            if (showFetchValues)
              asyncRepositoryData.when(
                data: (data) => Text(data),
                loading: () => CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
              ),
             SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
