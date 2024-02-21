import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/profile/userProfile.dart';
import 'package:ocean_guard/features/super_admin/cleaner_cards/cleaner_list.dart';
import 'package:provider/provider.dart';

class adminNavbar extends StatelessWidget {
  adminNavbar({super.key});

  final List<dynamic> screens = [
    const CardList(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    int currentScreenIndex = Provider.of<AdminNavbarIndexProvider>(context).navbarScreenIndex;
    return Scaffold(
      bottomNavigationBar:
      Consumer<AdminNavbarIndexProvider>(builder: (context, provider, child) {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.myBlue,
          unselectedItemColor: AppColors.myCommentGray,
          currentIndex: currentScreenIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            provider.setNavbarScreenIndex(value);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.trade), activeIcon: Icon(Iconsax.trade5, color: AppColors.myBlue), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Iconsax.profile_2user), activeIcon: Icon(Iconsax.profile_2user5, color: AppColors.myBlue), label: "Profile")
          ],
        );
      }),
      body: SafeArea(child: screens[currentScreenIndex]),
    );
  }
}

class AdminNavbarIndexProvider extends ChangeNotifier {
  int _navbarScreenIndex = 0;

  int get navbarScreenIndex => _navbarScreenIndex;

  void setNavbarScreenIndex(int value) {
    _navbarScreenIndex = value;
    notifyListeners();
  }
}
