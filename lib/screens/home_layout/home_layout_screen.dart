import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../tabs/hadeeth/hadeeth_tab.dart';
import '../tabs/quran/quran_tab.dart';
import '../tabs/radio/radio_tab.dart';
import '../tabs/sebha/sebha_tab.dart';
import '../tabs/time/time_tab.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    const QuranTab(),
    const HadithTab(),
    const SebhaTab(),
    const RadioTab(),
    const TimeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/Mosque-01.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: tabs[selectedIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: AppColors.primaryGold,
            ),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: AppColors.darkBackground,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage('assets/images/quran.png'), size: 30),
                  activeIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const ImageIcon(AssetImage('assets/images/quran.png'), size: 30),
                  ),
                  label: "Quran",
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage('assets/images/ic_hadeth.png'), size: 30),
                  activeIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const ImageIcon(AssetImage('assets/images/ic_hadeth.png'), size: 30),
                  ),
                  label: "Hadith",
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage('assets/images/ic_sebha.png'), size: 30),
                  activeIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const ImageIcon(AssetImage('assets/images/ic_sebha.png'), size: 30),
                  ),
                  label: "Tasbeeh",
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage('assets/images/ic_radio.png'), size: 30),
                  activeIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const ImageIcon(AssetImage('assets/images/ic_radio.png'), size: 30),
                  ),
                  label: "Radio",
                ),
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage('assets/images/ic_time.png'), size: 30),
                  activeIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const ImageIcon(AssetImage('assets/images/ic_time.png'), size: 30),
                  ),
                  label: "Time",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}