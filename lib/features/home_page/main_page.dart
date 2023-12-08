import 'package:flutter/material.dart';
import 'package:here/features/city_information/city_information_page.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> pages = const [
    CityInformationMainPage(),
    CityInformationMainPage(),
    CityInformationMainPage(),
  ];

  
  Widget _buildPage(int index) {
    return pages[index];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            const AppBarWidget(),
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


