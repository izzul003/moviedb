import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb_elements/core/res/app_colors.dart';
import 'package:moviedb_elements/core/res/widgets/app_search_bar.dart';
import 'package:moviedb_elements/features/movie/presentation/bloc/popular/popular_cubit.dart';
import 'package:moviedb_elements/features/movie/presentation/widgets/popular_movie_thumbnail.dart';
import 'package:moviedb_elements/injection_container.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  final PopularCubit _popularCubit = sl<PopularCubit>();
  String? searchQuery;

  @override
  void initState() {
    _popularCubit.getPopularMovieList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _popularCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SearchBar
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

                      _popularCubit.getPopularMovieList(searchQuery: searchQuery);
                    },
                  ),
                ),
              ),

              // 'Showing result of blabla..' text
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

              // The Grid
              _popularCubit.popularMovieList.isEmpty ? Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: const Text(
                    'Tidak ada dafter populer',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                ),
              ) : Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 10/17.5,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  padding: const EdgeInsets.all(8),
                  children: _popularCubit.popularMovieList.map<Widget>((prop) {
                    int index = _popularCubit.popularMovieList.indexWhere((p) => p.id == prop.id);
                    return PopularMovieThumbnail(
                      imageUrl: _popularCubit.popularMovieList[index].imageUrl,
                      title: _popularCubit.popularMovieList[index].title,
                      casts: _popularCubit.popularMovieList[index].genres ?? "",
                      onPressed: () {
                        context.go('/movie/${_popularCubit.popularMovieList[index].id}');
                      },
                    );
                  }).toList(),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
