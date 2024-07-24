import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb_elements/core/res/app_assets.dart';
import 'package:moviedb_elements/core/res/app_colors.dart';
import 'package:moviedb_elements/features/home/presentation/bloc/home_cubit.dart';
import 'package:moviedb_elements/features/home/presentation/widgets/movie_thumbnail.dart';
import 'package:moviedb_elements/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCubit _homeCubit = sl<HomeCubit>();

  final CarouselController _controller = CarouselController();

  int _carouselCurrentSection = 0;

  @override
  void initState() {
    _homeCubit.getMovieList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _homeCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                color: AppColors.appBar,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                              AppAssets.iconLogo,
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(width: 8),
                          Text('Elemes Movie', style: TextStyle(color: Colors.white)),
                          Text('DB', style: TextStyle(color: AppColors.primary)),
                        ],
                      ),
                      IconButton(
                        onPressed: () {

                        },
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _carouselSlider(),

                      const SizedBox(height: 28),

                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Popular Movies',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _homeCubit.movieList.length,
                            padding: const EdgeInsets.only(left: 20),
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                margin: const EdgeInsets.only(right: 8),
                                child: MovieThumbnail(
                                  imageUrl: _homeCubit.movieList[index].imageUrl,
                                  onPressed: () {
                                    context.go('/movie/${_homeCubit.movieList[index].id}');
                                  },
                                ),
                              );
                            },
                          )
                      ),

                      const SizedBox(height: 32),

                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Coming Soon',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _homeCubit.comingSoonList.length,
                            padding: const EdgeInsets.only(left: 20),
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                margin: const EdgeInsets.only(right: 8),
                                child: MovieThumbnail(
                                  imageUrl: _homeCubit.comingSoonList[index].imageUrl,
                                  onPressed: () {
                                    context.go('/movie/${_homeCubit.movieList[index].id}');
                                  },
                                ),
                              );
                            },
                          )
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _carouselSlider() {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: 280,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _carouselCurrentSection = index;
              });
            },
          ),
          items: _homeCubit.highlightMovieList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return MovieThumbnail(
                  imageUrl: i.imageUrl,
                  onPressed: () {
                    context.go('/movie/${i.id}');
                  },
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 16,
          left: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _homeCubit.highlightMovieList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: _carouselCurrentSection == entry.key ? 38 : 18,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: Colors.amber.withOpacity(_carouselCurrentSection == entry.key ? 0.9 : 0.4)
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
