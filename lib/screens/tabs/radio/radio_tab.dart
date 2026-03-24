import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  bool isRadioSelected = true;
  int playingIndex = 1;

  final List<String> radioStations = [
    "Radio Ibrahim Al-Akdar",
    "Radio Al-Qaria Yassen",
    "Radio Ahmed Al-trabulsi",
    "Radio Addokali Mohammad Alalim",
  ];

  final List<String> reciters = [
    "Ibrahim Al-Akdar",
    "Akram Alalaqmi",
    "Majed Al-Enezi",
    "Malik shaibat Alhamed",
  ];

  @override
  Widget build(BuildContext context) {
    List<String> currentList = isRadioSelected ? radioStations : reciters;

    return Stack(
      children: [
        Positioned.fill(
          child: Transform.translate(
            offset: const Offset(-30, 60),
            child: Transform.scale(
              scale: 1.15,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'assets/images/radio_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.6),
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
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isRadioSelected = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isRadioSelected
                                ? AppColors.primaryGold
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Radio",
                            style: TextStyle(
                              color:
                              isRadioSelected ? Colors.black : Colors.white,
                              fontSize: 18,
                              fontWeight: isRadioSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isRadioSelected = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isRadioSelected
                                ? AppColors.primaryGold
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Reciters",
                            style: TextStyle(
                              color: !isRadioSelected
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: !isRadioSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: currentList.length,
                  itemBuilder: (context, index) {
                    bool isPlaying = index == playingIndex;

                    return buildRadioCard(currentList[index], isPlaying, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRadioCard(String title, bool isPlaying, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 130,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.primaryGold,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: isPlaying ? 0.0 : 0.4,
              child: Image.asset(
                'assets/images/Mosque-02 2.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          if (isPlaying)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.5,
                child: SvgPicture.asset(
                  'assets/images/soundWave.png',
                  fit: BoxFit.cover,
                  height: 80,
                  colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          playingIndex = isPlaying ? -1 : index;
                        });
                      },
                      child: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.volume_up,
                      size: 30,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}