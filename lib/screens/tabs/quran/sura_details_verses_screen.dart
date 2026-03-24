import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../core/theme/app_colors.dart';

class SuraDetailsVersesScreen extends StatefulWidget {
  final int suraIndex;
  final String arabicName;
  final String englishName;

  const SuraDetailsVersesScreen({
    super.key,
    required this.suraIndex,
    required this.arabicName,
    required this.englishName,
  });

  @override
  State<SuraDetailsVersesScreen> createState() => _SuraDetailsVersesScreenState();
}

class _SuraDetailsVersesScreenState extends State<SuraDetailsVersesScreen> {
  List<String> verses = [];
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    loadSuraFile();
  }

  Future<void> loadSuraFile() async {
    String content = await rootBundle.loadString('assets/data/Suras/${widget.suraIndex}.txt');
    setState(() {
      verses = content.trim().split('\n');
    });
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
          Column(
            children: [
              _buildHeader(),
              Expanded(
                child: verses.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryGold,
                  ),
                )
                    : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
                  itemCount: verses.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    bool isActive = (index == selectedIndex);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: _buildVerseCard(verses[index], index + 1, isActive),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/img_left_corner.png', height: 80),
          Text(
            widget.arabicName,
            style: const TextStyle(
              color: AppColors.primaryGold,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset('assets/images/img_right_corner.png', height: 80),
        ],
      ),
    );
  }

  Widget _buildVerseCard(String content, int index, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryGold : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryGold, width: 2),
      ),
      child: Text(
        "[$index] $content",
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          color: isActive ? Colors.black : AppColors.primaryGold,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}