import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_elements/core/res/app_assets.dart';
import 'package:moviedb_elements/core/res/app_colors.dart';
import 'package:moviedb_elements/features/home/presentation/pages/home_screen.dart';
import 'package:moviedb_elements/features/main/presentation/bloc/main_cubit.dart';
import 'package:moviedb_elements/features/main/presentation/widgets/bottom_navigation_icon.dart';
import 'package:moviedb_elements/features/movie/presentation/pages/popular_screen.dart';
import 'package:moviedb_elements/features/movie/presentation/pages/watch_list_screen.dart';
import 'package:moviedb_elements/injection_container.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainCubit cubit = sl<MainCubit>();

  final menuWidgets = [
    const HomeScreen(),
    const PopularScreen(),
    const WatchListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(top: 12.0),
            color: AppColors.appBar,
            child: BottomNavigationBar(
              backgroundColor: AppColors.appBar,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primaryLight,
              unselectedItemColor: Colors.white,
              selectedFontSize: 12,
              currentIndex: cubit.activePage,
              onTap: (index) => cubit.changeActivePageIndex(index),
              items: const [
                BottomNavigationBarItem(
                  icon: BottomNavigationIcon(
                    image: AppAssets.iconHome,
                    color: Colors.white,
                  ),
                  activeIcon: BottomNavigationIcon(
                    image: AppAssets.iconHome,
                    color: AppColors.primaryLight,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationIcon(
                    image: AppAssets.iconAward,
                    color: Colors.white,
                  ),
                  activeIcon: BottomNavigationIcon(
                    image: AppAssets.iconAward,
                    color: AppColors.primaryLight,
                  ),
                  label: 'Popular',
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationIcon(
                    image: AppAssets.iconFavorite,
                    color: Colors.white,
                  ),
                  activeIcon: BottomNavigationIcon(
                    image: AppAssets.iconFavorite,
                    color: AppColors.primaryLight,
                  ),
                  label: 'Watch List',
                ),
              ],
            ),
          ),
          body: menuWidgets[cubit.activePage],
        );
      },
    );
  }
}
