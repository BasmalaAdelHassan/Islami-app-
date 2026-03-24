import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:islami/screens/tabs/quran/sura_details_verses_screen.dart';
import '../../../core/theme/app_colors.dart';

class SuraDetailsScreen extends StatefulWidget {
  final int suraIndex;
  final String arabicName;
  final String englishName;

  const SuraDetailsScreen({
    super.key,
    required this.suraIndex,
    required this.arabicName,
    required this.englishName,
  });

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  String suraContent = "";

  @override
  void initState() {
    super.initState();
    loadSuraFile();
  }

  Future<void> loadSuraFile() async {
    try {
      String content = await rootBundle.loadString(
        'assets/data/Suras/${widget.suraIndex}.txt',
      );

      List<String> lines = content.split('\n');
      String formattedText = "";
      for (int i = 0; i < lines.length; i++) {
        if (lines[i].trim().isNotEmpty) {
          formattedText += "${lines[i].trim()} [${i + 1}] ";
        }
      }

      setState(() {
        suraContent = formattedText;
      });
    } catch (e) {
      setState(() {
        suraContent = "حدث خطأ أثناء تحميل السورة.. تأكد من مسار واسم الملف.";
      });
    }
  }

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
          widget.englishName,
          style: const TextStyle(
            color: AppColors.primaryGold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuraDetailsVersesScreen(
                suraIndex: widget.suraIndex,
                arabicName: widget.arabicName,
                englishName: widget.englishName,
              ),
            ),
          );
        },
        child: Stack(
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
                      Image.asset(
                        'assets/images/img_left_corner.png',
                        height: 80,
                      ),
                      Text(
                        widget.arabicName,
                        style: const TextStyle(
                          color: AppColors.primaryGold,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        'assets/images/img_right_corner.png',
                        height: 80,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: suraContent.isEmpty
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryGold,
                      ),
                    )
                        : SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 120),
                      child: Text(
                        suraContent,
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
      ),
    );
  }
}