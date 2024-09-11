// service helper for loading json file
import 'package:flutter/services.dart' as rootBundle;
// package we need for json encode/decode
import 'dart:convert';
// A simple repository to simulate data fetching
class DataRepository {
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating network delay
    return "Data from Repository this is the hardcoded test";
  }
}

class MovieService {
  Future<List<dynamic>> fetchMovies() async {
    await Future.delayed(Duration(seconds: 1));
    // Load json data
    final moviesData = await rootBundle.rootBundle.loadString('data/movies.json');
    // Decode json data to list
    return json.decode(moviesData) as List<dynamic>;
  }
}