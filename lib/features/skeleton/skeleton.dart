// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:here/dummy_data/data.dart';

import 'package:here/features/homepage/home_page.dart';
import 'package:here/features/skeleton/controller/skeleton_repositoy_controller.dart';
import 'package:here/features/skeleton/widgets/new_city.dart';
import '../profile_page/profile_page.dart';
import 'package:here/models/city_model.dart';

import 'widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_bar.dart';

class Skeleton extends ConsumerStatefulWidget {
  const Skeleton({Key? key}) : super(key: key);

  static const routeName = '/homepage';

  @override
  ConsumerState<Skeleton> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<Skeleton> {
  int _currentIndex = 0;

  List<Widget> pages = const [
    HomePage(),
    HomePage(),
    ProfilePage(),
  ];

  CityModel? city = CityModel(
    name: dummy_city_data['city'] as String,
    countryName: dummy_city_data['country'] as String,
    info: dummy_city_data['info'] as String,
  );
  
  // void setData() async {
  //   await ref.watch(HomePageControllerProvider).setCurrentCity(context);
  //   setState(() {
  //     city = ref.watch(HomePageControllerProvider).getCityDetails();
  //   });
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // setData();
  // }

  Widget _buildPage(int index) {
    return pages[index];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Check if city is null and show loading screen accordingly
    if (city == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.width * 0.04,
            ),
            AppBarWidget(
              cityName: city!.name,
              countryName: city!.countryName,
              onFindCityPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewCityInput(),
                  ),
                );
              },
              // favoriteCities: ["Mumbai", "Hyderabad"],
            ),
            _buildPage(_currentIndex),
            BottomNavBar(
              size: size,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
