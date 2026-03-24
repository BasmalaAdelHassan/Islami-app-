import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HadithDetailsScreen extends StatelessWidget {
  final String title;
  final String content;
  final int index;

  const HadithDetailsScreen({
    super.key,
    required this.title,
    required this.content,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryGold),
        centerTitle: true,
        title: Text(
          "Hadith $index",
          style: const TextStyle(
            color: AppColors.primaryGold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/img_bottom_decoration.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/img_left_corner.png', height: 80),
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.primaryGold,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset('assets/images/img_right_corner.png', height: 80),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: AppColors.primaryGold,
                        fontSize: 20,
                        height: 2.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}