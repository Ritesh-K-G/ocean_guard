import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/past_queries/queries_list.dart';
import 'package:ocean_guard/features/profile/userProfile.dart';
import 'package:ocean_guard/features/submit_query/query_form.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  Navbar({super.key});

  final List<dynamic> screens = [
    const ProfileScreen(),
    QueriesDashBoard(),
    const QueryForm()
  ];

  @override
  Widget build(BuildContext context) {
    int currentScreenIndex = Provider.of<NavbarIndexProvider>(context).navbarScreenIndex;
    return Scaffold(
      bottomNavigationBar:
      Consumer<NavbarIndexProvider>(builder: (context, provider, child) {
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
            BottomNavigationBarItem(icon: Icon(Iconsax.profile_2user), activeIcon: Icon(Iconsax.profile_2user5, color: AppColors.myBlue), label: "Profile"),
            BottomNavigationBarItem(icon: Icon(Iconsax.hashtag), activeIcon: Icon(Iconsax.hashtag5, color: AppColors.myBlue), label: "My Queries"),
            BottomNavigationBarItem(icon: Icon(Iconsax.trade), activeIcon: Icon(Iconsax.trade5, color: AppColors.myBlue), label: "Complaint")
          ],
        );
      }),
      body: SafeArea(child: screens[currentScreenIndex]),
    );
  }
}

class NavbarIndexProvider extends ChangeNotifier {
  int _navbarScreenIndex = 0;

  int get navbarScreenIndex => _navbarScreenIndex;

  void setNavbarScreenIndex(int value) {
    _navbarScreenIndex = value;
    notifyListeners();
  }
}
