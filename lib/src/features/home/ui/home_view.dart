import 'package:digital_sobol_test/src/core/ui/app_colors.dart';
import 'package:digital_sobol_test/src/core/ui/app_svgs.dart';
import 'package:digital_sobol_test/src/features/home/ui/accounts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() =>
      _HomeViewState();
}

class _HomeViewState
    extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetOptions = <Widget>[
      const Scaffold(),
      AccountsPage(
        onBackTap: () {
          _onItemTapped(0);
        },
      ),
    ];
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _selectedIndex == 0
                  ? AppSVGs.projectsIconSelected
                  : AppSVGs.projectsIconUnselected,
            ),
            label: 'Мои проекты',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSVGs.userIcon,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1
                    ? AppColors.blue
                    : AppColors.bottomNavBarGrey,
                BlendMode.srcATop,
              ),
            ),
            label: 'Мой аккаунт',
          ),
        ],
        selectedItemColor: AppColors.blue,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: AppColors.blue,
              fontWeight: FontWeight.w500,
            ),
        unselectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: AppColors.bottomNavBarGrey,
              fontWeight: FontWeight.w500,
            ),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
