import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb_elements/core/res/app_assets.dart';
import 'package:moviedb_elements/core/res/app_colors.dart';
import 'package:moviedb_elements/core/res/widgets/app_button.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';
import 'package:moviedb_elements/features/movie/presentation/bloc/movie_detail/movie_detail_cubit.dart';
import 'package:moviedb_elements/injection_container.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({super.key, required this.id});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final MovieDetailCubit _cubit = sl<MovieDetailCubit>();


  @override
  void initState() {
    _cubit.getMovieDetail(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cubit,
      listener: (context, state) {
        if (state is ToggleFavoritesSuccessful) {
          _cubit.getMovieDetail(widget.id);

          String message = state.movie != null
              ? "Berhasil menambahkan ke favorit"
              : "Berhasil menghapus dari favorit";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));
        } else if (state is ToggleFavoritesFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Gagal toggle favorite'),
          ));
        }
      },
      child: BlocBuilder(
        bloc: _cubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: _cubit.getMovieDetailLoading ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
              ),
            ) : SingleChildScrollView(
              child: Stack(
                children: [
                  _backdrop(),

                  // AppBar
                  SafeArea(
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: IconButton(
                        onPressed: () {
                          context.pushReplacement('/app');
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                    child: Column(
                      children: [
                        // Main Contents
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _cubit.movieDetail?.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700
                                ),
                              ),

                              const SizedBox(height: 9),

                              Row(
                                children: [
                                  Text(
                                    _cubit.movieDetail?.duration ?? '',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.7)
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  SvgPicture.asset(
                                    AppAssets.iconHdWhite,
                                    height: 15,
                                    width: 15,
                                  )
                                ],
                              ),

                              const SizedBox(height: 13),

                              Row(
                                children: _cubit.movieDetail?.genres.split(',').asMap().entries.map((entry) {
                                  return Row(
                                    children: [
                                      Text(
                                        entry.value,
                                        style: const TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                      entry.key != ((_cubit.movieDetail?.genres.split(',').length ?? 1) -1) ? Container(
                                        width: 4, height: 4,
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary
                                        ),
                                      ) : const SizedBox()
                                    ],
                                  );
                                }).toList() ?? [const SizedBox()],
                              ),

                              const SizedBox(height: 24),

                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: AppButton(
                                        style: AppButtonStyle.primary,
                                        text: 'Watch Trailer',
                                        iconSvgUri: AppAssets.iconPlay,
                                        onPressed: () {}
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: AppButton(
                                        style: AppButtonStyle.secondary,
                                        text: _cubit.movieDetail?.isFavorite != null ?  _cubit.movieDetail?.isFavorite == true ? 'Remove Favorite' : 'Add to Favorite' : '',
                                        iconSvgUri: AppAssets.iconPlus,
                                        iconColor: AppColors.primary,
                                        onPressed: () {
                                          _cubit.toggleFavorite(Movie(
                                              id: widget.id,
                                              title: _cubit.movieDetail!.title,
                                              imageUrl: _cubit.movieDetail!.imageUrl,
                                              genres: _cubit.movieDetail!.genres,
                                              year: _cubit.movieDetail!.year,
                                              isFavorite: _cubit.movieDetail!.isFavorite
                                          ));
                                        }
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              Text(
                                _cubit.movieDetail?.overview ?? '',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.7)
                                ),
                              ),

                              const SizedBox(height: 32),

                              const Text(
                                'Cast',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Cast
                        SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: _cubit.movieDetail?.casts.length,
                              padding: const EdgeInsets.only(left: 20),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 14),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: _cubit.movieDetail?.casts[index].photoUrl ?? '',
                                        imageBuilder: (context, imageProvider) => Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider, fit: BoxFit.cover
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => const SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: Center(child: CircularProgressIndicator())
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(0.3)
                                            ),
                                            child: const Center(child: Icon(Icons.error))
                                        ),
                                      ),

                                      const SizedBox(height: 16),

                                      Text(
                                        _cubit.movieDetail?.casts[index].name ?? '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _backdrop() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: _cubit.movieDetail?.imageUrl ?? '',
          height: MediaQuery.of(context).size.height * 0.65,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.66,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.1, 0.4, 1],
                  colors: [
                    AppColors.background,
                    AppColors.background.withOpacity(0.6),
                    Colors.transparent
                  ]
              )
          ),
        ),
      ],
    );
  }
}
