import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  int phraseIndex = 0;
  double rotationAngle = 0.0;

  List<String> tasbeehPhrases = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
  ];

  void onSebhaTap() {
    setState(() {
      rotationAngle += 1 / 33;
      counter++;

      if (counter == 33) {
        counter = 0;
        phraseIndex = (phraseIndex + 1) % tasbeehPhrases.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/sebha_bg.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.6),
          ),
        ),
        SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const SizedBox(height: 30),
                const Text(
                  "سَبِّحِ اسْمَ رَبِّكَ الْأَعْلَى",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Image.asset(
                        'assets/images/Mask group.png',
                        height: 75,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -2),
                      child: GestureDetector(
                        onTap: onSebhaTap,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedRotation(
                              turns: rotationAngle,
                              duration: const Duration(milliseconds: 200),
                              child: Image.asset(
                                'assets/images/SebhaBody 1.png',
                                width: 340,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tasbeehPhrases[phraseIndex],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "$counter",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}