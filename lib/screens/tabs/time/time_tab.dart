import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/theme/app_colors.dart';
import 'azkar_details_screen.dart';

class TimeTab extends StatelessWidget {
  const TimeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/more_bg.png', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withValues(alpha: 0.7)),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/Mosque-01.png', height: 150, width: double.infinity, fit: BoxFit.cover),
                    Image.asset('assets/images/Islami.png', height: 50),
                  ],
                ),
                const SizedBox(height: 20),
                _buildMainPrayCard(),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Azkar",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: buildAzkarCard(context, "Evening Azkar", 'assets/images/Illustration (1).png', "أذكار المساء")),
                    const SizedBox(width: 15),
                    Expanded(child: buildAzkarCard(context, "Morning Azkar", 'assets/images/Illustration.png', "أذكار الصباح")),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainPrayCard() {
    final List<Map<String, String>> prayerTimes = [
      {"name": "Fajr", "time": "04:04", "period": "AM"},
      {"name": "Dhuhr", "time": "01:01", "period": "PM"},
      {"name": "ASR", "time": "04:38", "period": "PM"},
      {"name": "Maghrib", "time": "07:57", "period": "PM"},
      {"name": "Isha", "time": "09:20", "period": "PM"},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryGold,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),

          CarouselSlider.builder(
            itemCount: prayerTimes.length,
            options: CarouselOptions(
              height: 150,
              viewportFraction: 0.28,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              initialPage: 2,
              enableInfiniteScroll: true,
              padEnds: true,
            ),
            itemBuilder: (context, index, realIndex) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF202020), Color(0xFFB19768)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(prayerTimes[index]['name']!, style: const TextStyle(color: Colors.white, fontSize: 13)),
                    const SizedBox(height: 5),
                    Text(prayerTimes[index]['time']!, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    Text(prayerTimes[index]['period']!, style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildNextPrayRow(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCustomEdge("16 Jul,\n2024", true),
            _buildCustomEdge("09 Muh,\n1446", false),
          ],
        ),

        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Pray Time", style: TextStyle(color: Colors.black, fontSize: 16)),
              Text("Tuesday", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomEdge(String text, bool isLeft) {
    return Container(
      width: 90,
      height: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF856B3F),
        borderRadius: BorderRadius.only(
          topLeft: isLeft ? const Radius.circular(40) : Radius.zero,
          topRight: !isLeft ? const Radius.circular(40) : Radius.zero,
          bottomRight: isLeft ? const Radius.circular(30) : Radius.zero,
          bottomLeft: !isLeft ? const Radius.circular(30) : Radius.zero,

        ),
      ),
      child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget _buildNextPrayRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Next Pray - 02:32", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(width: 15),
        Icon(Icons.volume_off, color: Colors.black),
      ],
    );
  }

  Widget buildAzkarCard(BuildContext context, String title, String imagePath, String categoryName) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AzkarDetailsScreen(categoryName: categoryName))),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.primaryGold, width: 2),
        ),
        child: Column(
          children: [
            Expanded(child: Padding(padding: const EdgeInsets.all(12.0), child: Image.asset(imagePath, fit: BoxFit.contain))),
            Padding(padding: const EdgeInsets.only(bottom: 15.0), child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}