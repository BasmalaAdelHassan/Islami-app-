import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../core/theme/app_colors.dart';
import 'hadith_details_screen.dart';

class HadithModel {
  final String title;
  final String content;
  HadithModel({required this.title, required this.content});
}

class HadithTab extends StatefulWidget {
  const HadithTab({super.key});

  @override
  State<HadithTab> createState() => _HadithTabState();
}

class _HadithTabState extends State<HadithTab> {
  List<HadithModel> allHadiths = [];

  final PageController _pageController = PageController(
    viewportFraction: 0.72,
    initialPage: 50000,
  );

  @override
  void initState() {
    super.initState();
    loadHadithFiles();
  }

  void loadHadithFiles() async {
    List<HadithModel> tempHadiths = [];

    for (int i = 1; i <= 50; i++) {
      try {
        String fileContent = await rootBundle.loadString('assets/data/Hadeeth/h$i.txt');
        List<String> lines = fileContent.trim().split('\n');

        if (lines.isNotEmpty) {
          String title = lines[0];
          lines.removeAt(0);
          String content = lines.join('\n');

          tempHadiths.add(HadithModel(title: title, content: content));
        }
      } catch (e) {
        break;
      }
    }

    setState(() {
      allHadiths = tempHadiths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.darkBackground,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.70,
          child: Image.asset(
            'assets/images/Background.png',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/Mosque-01.png',
                      height: 150, width: double.infinity, fit: BoxFit.cover),
                  Image.asset('assets/images/Islami.png', height: 50),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: allHadiths.isEmpty
                    ? const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryGold))
                    : PageView.builder(
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final realIndex = index % allHadiths.length;

                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double scale = 1.0;

                        if (_pageController.position.haveDimensions) {
                          double page = _pageController.page!;
                          double difference = (page - index).abs();
                          scale =
                              (1 - (difference * 0.10)).clamp(0.90, 1.0);
                        } else {
                          scale = index == 50000 ? 1.0 : 0.90;
                        }

                        return Transform.scale(
                          scale: scale,
                          child: buildHadithCard(
                              allHadiths[realIndex], realIndex),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHadithCard(HadithModel hadith, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HadithDetailsScreen(
              title: hadith.title,
              content: hadith.content,
              index: index + 1,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.primaryGold,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/Mosque-02 2.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/images/welcome.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
                top: 12,
                left: 12,
                child: Image.asset('assets/images/left_corner.png', height: 80)),
            Positioned(
                top: 12,
                right: 12,
                child:
                Image.asset('assets/images/right_corner.png', height: 80)),
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 16, right: 16, bottom: 80),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    hadith.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        hadith.content,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}