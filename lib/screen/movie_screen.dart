import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myflutter_exp1/model/movie..dart';
import 'package:http/http.dart' as http;
import 'package:myflutter_exp1/provider/movie_provider.dart';
import 'package:myflutter_exp1/size_helper.dart';

final movieProvider = Provider<GetDataFromMovieApi>((ref) => GetDataFromMovieApi());
final response = FutureProvider<List<Movie>>((ref) {
  final getData = ref.read(movieProvider);
  return getData.getMovieList();
});

class MovieScreen extends ConsumerWidget {
  final List<Movie> _movies = <Movie>[];
  
  MovieScreen({Key? key}) : super(key: key);

  void _populateAllMovies() async {
    final movies = await _fetchAllMovies();
  }

  Future<List<Movie>> _fetchAllMovies() async {
    print("Fetch movie");
    var response;
    try {
        final responseApi = await http.get(
        Uri.parse("http://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa")).timeout(const Duration(seconds: 2));
        response = responseApi;
    }
    on TimeoutException catch (_) {
      print("time out lo");
    }

    if (response?.statusCode == 200) {
      print("success");
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load movies.");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(response);
    return viewModel.when(  
      error: (err, stack, _) => Container(
        child: Column(
          children: [
            Image.asset("assets/images/loading.png"),
            Text('Something went wrong! Try again.')
          ],
        ),
      ),
      data: (response) {
        return LayoutBuilder(
          builder: (context, BoxConstraints boxConstraints) {
           
            return Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: ListView.builder(
                itemCount: response.length ?? 0,
                itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: response[index]?.poster ?? "https://picsum.photos/250?image=9", placeholder: (ctx, url) => CircularProgressIndicator(), errorWidget: (ctx, url, err) => Icon(Icons.error),

                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(response[index].title ?? "N/A"),
                                  Text(response[index].year ?? "N/A", style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                },
              ),
            );
          },
        );
    }, 
    loading: (_) => Container(child: CircularProgressIndicator(),)); 
    
    // return LayoutBuilder(
    //   builder: (context, cts) {
    //     return Container(
    //       margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    //       child: FutureBuilder<List<Movie>>(
    //         future: _fetchAllMovies(),
    //         builder: (context, AsyncSnapshot<List<Movie>> snapshot) {

    //           if (snapshot.connectionState == ConnectionState.none) {
    //             return Container(
    //               child: Column(
    //                 children: [
    //                   Image.asset("assets/images/loading.png"),
    //                   Text('Something went wrong! Try again.')
    //                 ],
    //               ),
    //             );
              
    //           }
    //           if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
    //             return ListView.builder(
    //             itemCount: snapshot.data?.length,
    //             itemBuilder: (context, index) {
    //               final movie = snapshot.data?[index];
          
    //               return ListTile(
    //                 onTap: () => Fluttertoast.showToast(msg: "Stay Tune, Coming soon!", gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_SHORT),
    //                 leading: Padding(
    //                   padding: const EdgeInsets.only(top: 50),
    //                   child: Icon(Icons.star_border_outlined,),
    //                 ),
    //                 trailing: FaIcon(FontAwesomeIcons.equals),
    //                 title: Row(
    //                   children: [
    //                     SizedBox(
    //                       width: 100,
    //                       child: ClipRRect(
    //                         child: CachedNetworkImage(
    //                           imageUrl: movie?.poster ??
    //                               "https://picsum.photos/250?image=9",
    //                           placeholder: (ctx, url) => CircularProgressIndicator( strokeWidth: 1.0,),
    //                           errorWidget: (ctx, url, err) => Icon(Icons.error),
    //                         ),
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                     ),
    //                     Flexible(
    //                       child: Padding(
    //                         padding: EdgeInsets.all(8.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(movie?.title ?? "N/A" ),
    //                             Text(movie?.year ?? "N/A", style: TextStyle(fontWeight: FontWeight.bold),)
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               );
    //             },
    //           );
    //           } 
    //           else {
    //             return Container(
    //               alignment: Alignment.center,
    //               child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 CircularProgressIndicator(),
    //                 Text('Loading...')
    //               ],
    //             ),);
    //           }
              
    //         },
    //       ),
    //     );
    //   }
    // );
  }
}
