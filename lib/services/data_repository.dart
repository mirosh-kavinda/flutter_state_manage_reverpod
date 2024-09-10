// A simple repository to simulate data fetching
class DataRepository {
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    return "Data from Repository this is the hardcoded test";
  }
}
