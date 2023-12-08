import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:here/features/city_information/city_information_page.dart';
import 'package:here/features/home_page/controller/home_page_repositoy_controller.dart';
import 'package:here/features/home_page/widgets/new_city.dart';
import '../profile_page/profile_page.dart';
import 'package:here/models/city_model.dart';

import 'widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  List<Widget> pages = const [
    CityInformationMainPage(),
    CityInformationMainPage(),
    ProfilePage(),
  ];

  CityModel? city;

  @override
  void initState() {
    super.initState();
    // Use asynchronous operation in initState, like Future.delayed
    // to avoid triggering LateInitializationError
    Future.delayed(Duration.zero, () async {
      await ref.watch(HomePageControllerProvider).setCurrentCity();
      setState(() {
        city = ref.watch(HomePageControllerProvider).getCityDetails();
      });
    });
  }

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
