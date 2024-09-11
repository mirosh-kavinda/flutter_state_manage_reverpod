
# Riverpod-Based Flutter Sample Project

This project demonstrates an **Flutter application** using **Riverpod** for state management. It highlights essential concepts like `Provider`, `StateProvider`, `StateNotifierProvider`, and navigation using `Navigator 2.0` with the **RouterDelegate** pattern. The architecture is designed to be scalable and maintainable, keeping the business logic, state management, and UI structure separate.

## Project Overview

This sample app is built to showcase how to effectively use Riverpod for state management in Flutter. The project includes:
- Simple 
- State management with `StateNotifier` and `StateProvider`
- Navigation using `Navigator 2.0` and Riverpod
- Separation of concerns: Providers, Models, and Services

## Key Concepts and Techniques

### 1. **Riverpod State Management**

Riverpod is a state management solution for Flutter that helps you manage state without coupling it to the UI. This project uses the following types of providers:

- **`Provider`**: This is a simple provider used for providing immutable data.
- **`StateProvider`**: This is used to manage simple pieces of state that can change over time.
- **`StateNotifierProvider`**: Used to manage more complex state that involves business logic, using a `StateNotifier` to control the state.

### 2. **ProviderScope**

The `ProviderScope` widget wraps the entire app to manage the lifecycle of all Riverpod providers. This ensures that the providers and their states are properly initialized, updated, and disposed of as required.

```dart
void main() {
  runApp(ProviderScope(child: MyApp()));
}
```

### 3. **State Management with Riverpod Providers**

- **Simple Provider:**
  
  The `Provider` provides static or immutable data to the app. In this project, it's used to return a simple "Hello, Riverpod!" message.

  ```dart
  final helloWorldProvider = Provider<String>((ref) {
    return 'Hello, Riverpod!';
  });
  ```

- **StateProvider:**

  The `StateProvider` is used to manage simple states, such as a counter that increments or decrements based on user actions. It's a great tool for handling lightweight state without complex logic.

  ```dart
  final counterProvider = StateProvider<int>((ref) {
    return 0;
  });
  ```

  In the UI, you can increment or decrement the counter using Riverpod’s `read` method, and the UI will automatically rebuild when the value changes:

  ```dart
  ref.read(counterProvider.notifier).state++;
  ```

- **StateNotifierProvider:**

  `StateNotifierProvider` is used for more complex state management where business logic is required. This project defines a `CounterNotifier` to encapsulate all the logic related to counter updates.

  ```dart
  class CounterNotifier extends StateNotifier<CounterState> {
    CounterNotifier() : super(CounterState(0));

    void increment() => state = CounterState(state.value + 1);
    void decrement() => state = CounterState(state.value - 1);
  }
  ```

  The `StateNotifierProvider` exposes the `CounterNotifier` in the UI:

  ```dart
  final counterNotifierProvider = StateNotifierProvider<CounterNotifier, CounterState>((ref) {
    return CounterNotifier();
  });
  ```

  The state and its updates are consumed in the UI using `watch` to reactively update the interface:

  ```dart
  final counterState = ref.watch(counterNotifierProvider);
  ```

### 4. **Repository Pattern with Providers**

This project uses a simple repository pattern to separate data fetching logic from the UI. The repository is provided using Riverpod’s `Provider`, making it easy to inject into the necessary components.

- **Repository Implementation:**

  The `DataRepository` simulates a data-fetching service and returns data after a delay.

  ```dart
  class DataRepository {
    Future<String> fetchData() async {
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay
      return "Data from Repository";
    }
  }
  ```

- **Repository Provider:**

  The repository is provided using Riverpod’s `Provider`. A `FutureProvider` is used to handle the asynchronous nature of the data-fetching process.

  ```dart
  final dataRepositoryProvider = Provider<DataRepository>((ref) {
    return DataRepository();
  });

  final repositoryDataProvider = FutureProvider<String>((ref) async {
    final repository = ref.watch(dataRepositoryProvider);
    return repository.fetchData();
  });
  ```

### 5. **Navigation with Navigator 2.0**

This project uses **Navigator 2.0** with a custom `RouterDelegate` to handle navigation scenarios. The navigation state is also managed using Riverpod.

- **RouterDelegate:**

  The `MyRouterDelegate` class is responsible for handling route changes and updating the UI accordingly. The current route is stored in a `StateProvider`, and changes to the route are reflected in the app’s navigation state.

  ```dart
  final currentRouteProvider = StateProvider<String>((ref) {
    return '/';
  });

  class MyRouterDelegate extends RouterDelegate with ChangeNotifier {
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
    Future<void> setNewRoutePath(configuration) async {
      ref.read(currentRouteProvider.notifier).state = configuration as String;
    }
  }
  ```

- **Route Handling:**

  The route changes are managed using Riverpod's `StateProvider` to store the current route. The `RouterDelegate` listens for changes and updates the route accordingly.

  ```dart
  ref.read(currentRouteProvider.notifier).state = '/details';
  ```

This allows for more flexible and dynamic routing compared to the traditional `Navigator.push` approach.

### 6. **Scalable Architecture**

The architecture is designed to be scalable and modular. The following project structure is used to organize different parts of the app:

```
lib/
├── main.dart                  # App entry point
├── providers/                 # Riverpod providers
│   ├── simple_provider.dart    # Simple providers for state management
│   ├── state_notifier_provider.dart # StateNotifier logic for complex state
│   ├── repository_provider.dart     # Providers for repository pattern
├── pages/                     # App pages/screens
│   ├── home_page.dart          # Home screen with state management
│   └── details_page.dart       # Details screen for navigation example
├── models/                    # Data models
│   └── counter_state.dart      # Model for CounterState
├── services/                  # Service layer
│   └── data_repository.dart    # Simulated data-fetching service
└── navigation/                # Custom navigation logic
    └── router_delegate.dart    # Navigator 2.0 router delegate
```

## Setup Instructions

### 1. Install Dependencies

Ensure you have Flutter and Dart installed. To get the project dependencies, run the following command in the project directory:

```bash
flutter pub get
```

### 2. Run the App

You can run the app with the following command:

```bash
flutter run
```

### 3. Riverpod Concepts Used in This Project

- **ProviderScope**: Wraps the entire app to manage Riverpod's state lifecycle.
- **Provider**: Provides simple data.
- **StateProvider**: Used to manage simple mutable state.
- **StateNotifierProvider**: Manages more complex state using the `StateNotifier` class.
- **FutureProvider**: Manages asynchronous data-fetching processes.
- **Navigator 2.0 with RouterDelegate**: Handles navigation using Riverpod’s state management.

## Project Features

- **Simple and  State Management**: The project showcases basic and  state management techniques with Riverpod.
- **Modular Architecture**: Providers, models, services, and navigation are separated to ensure scalability and maintainability.
- **RouterDelegate Navigation**: Demonstrates dynamic route handling using `Navigator 2.0` and Riverpod.

## Conclusion

This project serves as a starting point for building more complex Flutter applications with Riverpod for state management. By following the architectural patterns demonstrated here, you can easily scale the app by adding more providers, complex business logic, and dynamic navigation flows.
