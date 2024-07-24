import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb_elements/core/res/app_colors.dart';
import 'package:moviedb_elements/core/res/widgets/app_search_bar.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';
import 'package:moviedb_elements/features/movie/presentation/bloc/watch_list/watch_list_cubit.dart';
import 'package:moviedb_elements/features/movie/presentation/widgets/favorite_thumbnail.dart';
import 'package:moviedb_elements/injection_container.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  final WatchListCubit _cubit = sl<WatchListCubit>();
  String? searchQuery;

  @override
  void initState() {
    _cubit.getFavoriteList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.background,
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8
                  ),
                  color: AppColors.appBar,
                  child: SafeArea(
                    child: AppSearchBar(
                      hint: 'Search',
                      onQueryChanged: (String searchQuery) {
                        setState(() {
                          this.searchQuery = searchQuery;
                        });

                        _cubit.getFavoriteList(searchQuery: searchQuery);
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: _body(),
                )
              ],
            )
        );
      },
    );
  }

  Widget _body() {
    if (_cubit.getFavoriteListLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor:
          AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
        ),
      );
    }

    if (_cubit.favoriteList.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada daftar favorite',
          style: TextStyle(
              fontSize: 16,
              color: Colors.white
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchQuery != null && searchQuery != '' ? Container(
          margin: const EdgeInsets.only(top: 16, left: 20),
          child: RichText(
            maxLines: 1,
            textScaleFactor: 1,
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'Showing result of ',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
              ),
              children: <TextSpan>[
                TextSpan(
                    text: "'$searchQuery'",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )
                ),
              ],
            ),
          ),
        ) : const SizedBox(),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _cubit.favoriteList.length,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemBuilder: (context, index) {
              return FavoriteThumbnail(
                imageUrl: _cubit.favoriteList[index].imageUrl,
                title: _cubit.favoriteList[index].title,
                year: _cubit.favoriteList[index].year,
                genres: _cubit.favoriteList[index].genres,
                onPressed: () {
                  context.go('/movie/${_cubit.favoriteList[index].id}');
                },
                onToggle: () {
                  // Only for delete needs, it's okay if not fulfilling all data
                  _cubit.toggleFavorite(Movie(
                      id: _cubit.favoriteList[index].id,
                      title: _cubit.favoriteList[index].title,
                      imageUrl: _cubit.favoriteList[index].imageUrl,
                      genres: "",
                      year: "",
                      isFavorite: _cubit.favoriteList[index].isFavorite
                  ));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
