import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/data_service.dart';

// Provide the repository
final dataRepositoryProvider = Provider<DataRepository>((ref) {
  return DataRepository();
});

// Use the repository to fetch data with FutureProvider
final repositoryDataProvider = FutureProvider<String>((ref) async {
  final repository = ref.watch(dataRepositoryProvider);
  return repository.fetchData();
});
