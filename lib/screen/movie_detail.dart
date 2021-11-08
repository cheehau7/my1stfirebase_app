import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myflutter_exp1/authentication.dart';
import 'package:myflutter_exp1/model/love_movie.dart';
import 'package:myflutter_exp1/model/movie..dart';
import 'package:myflutter_exp1/provider/movie_provider.dart';
import 'dart:io' show Platform;

import 'package:uiblock/uiblock.dart';

final favMovieProvider =
    StateProvider<GetDataFromMovieApi>((ref) => GetDataFromMovieApi());

class MovieDetailScreen extends ConsumerWidget {
  MovieDetailScreen({Key? key}) : super(key: key);
  static const routeName = "movie/movie-detail-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favMovie = ref.watch(favMovieProvider);
    final movie = ModalRoute.of(context)?.settings.arguments as Movie?;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, BoxConstraints cts) {
            return Container(
              height: cts.maxHeight,
              color: Colors.indigoAccent,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: cts.maxHeight * 0.65,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[
                              Colors.black.withOpacity(1.0),
                              Colors.black.withOpacity(1.0),
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.3),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.topCenter,
                            stops: [0.0, 0.5, 0.55, 1.0])),
                    width: double.infinity,
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl: movie?.poster ??
                            "https://picsum.photos/250?image=9",
                        fit: BoxFit.fill,
                        placeholder: (ctx, url) => Center(
                          child: SizedBox(
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.indigo),
                                  )
                                : CupertinoActivityIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xCC000000),
                          const Color(0x00000000),
                          const Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: cts.maxHeight * 0.4,
                    margin: EdgeInsets.only(top: cts.maxHeight * 0.6),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: SelectableText(
                                      "${movie?.title ?? "Error occur."} \nYear: ${movie?.year ?? "Unknown"}s",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          var uuid =
                                              await AuthenticationHelper()
                                                  .getUUID();
                                          if (uuid != null) {
                                            print("uuid not null");
                                            //GetDataFromMovieApi(Movie.fromJson());
                                            favMovie.state.addFavMovie(FavMovie(
                                              id: movie!.imdbId,
                                              uuid: uuid,
                                              date_add:
                                                  DateTime.now().toString(),
                                            )).whenComplete(() {
                                              print("Successful added");
                                            });
                                            
                                          }
                                        },
                                        icon: Icon(
                                          Icons.favorite_border,
                                          size: 30,
                                        ),
                                        tooltip: "Add to your favourite list.",
                                      ),
                                      Text("Add to your favourite list")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: cts.maxHeight * 0.07,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                // color: Colors.indigo,
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                  Colors.purple,
                                  Colors.indigoAccent,
                                ])),
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  UIBlock.block(context,
                                      backgroundColor: Colors.transparent);
                                  await Future.delayed(Duration(seconds: 3));
                                  UIBlock.unblock(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Unvailable now")));
                                },
                                icon: Icon(Icons.watch_later),
                                label: Text("Watch Later")),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).padding.top,
                      child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: FaIcon(
                            FontAwesomeIcons.arrowAltCircleLeft,
                            color: Colors.white,
                            size: 30,
                          )))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _addFavMovie() {}
}
