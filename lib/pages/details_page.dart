import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../navigation/router_delegate.dart';
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DetailsPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     void _handleBackButton() {
//       final routerDelegate = Router.of(context).routerDelegate as MyRouterDelegate;
//       routerDelegate.popRoute();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: _handleBackButton,
//         ),
//         title: Text('Details Page', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Text(
//           'Welcome to the Details Page',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }



class DetailsPage extends ConsumerWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = ThemeData();

    List<Movie> formattedMovies = ref.watch(moviesProvider).movies;
    bool isLoading = ref.watch(moviesProvider).isLoading;

    return MaterialApp(
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.black,
            secondary: Colors.blue,
          ),
        ),
        title: 'Le Movies Page',
        home: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                    onChanged: (text) async {
                      // text here is the inputed text
                      await ref.read(moviesProvider.notifier).filterMovies(text);
                    },
                  ),
                ),
                isLoading ? CircularProgressIndicator() : Expanded(
                  child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: formattedMovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            Movie movie = formattedMovies[index];

                            return MovieCard(movie: movie);
                          })),
                )
              ],
            ),
          ),
        ));
  }
}
