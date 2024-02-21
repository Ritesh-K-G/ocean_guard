import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/cleaner/resolved_list/resolved_list.dart';
import 'package:ocean_guard/features/cleaner/to_do_list/to_do_list.dart';
import 'package:ocean_guard/features/profile/userProfile.dart';
import 'package:provider/provider.dart';

class cleanerNavbar extends StatelessWidget {
  cleanerNavbar({super.key});

  final List<dynamic> screens = [
    const todoList(),
    const ResolvedList(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    int currentScreenIndex = Provider.of<CleanerNavbarIndexProvider>(context).navbarScreenIndex;
    return Scaffold(
      bottomNavigationBar:
      Consumer<CleanerNavbarIndexProvider>(builder: (context, provider, child) {
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
            BottomNavigationBarItem(icon: Icon(Iconsax.trade), activeIcon: Icon(Iconsax.trade5, color: AppColors.myBlue), label: "Queries"),
            BottomNavigationBarItem(icon: Icon(Iconsax.hashtag), activeIcon: Icon(Iconsax.hashtag5, color: AppColors.myBlue), label: "Resolved"),
            BottomNavigationBarItem(icon: Icon(Iconsax.profile_2user), activeIcon: Icon(Iconsax.profile_2user5, color: AppColors.myBlue), label: "Profile")
          ],
        );
      }),
      body: SafeArea(child: screens[currentScreenIndex]),
    );
  }
}

class CleanerNavbarIndexProvider extends ChangeNotifier {
  int _navbarScreenIndex = 0;

  int get navbarScreenIndex => _navbarScreenIndex;

  void setNavbarScreenIndex(int value) {
    _navbarScreenIndex = value;
    notifyListeners();
  }
}
