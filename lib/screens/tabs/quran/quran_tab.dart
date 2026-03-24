import 'package:flutter/material.dart';
import 'package:islami/screens/tabs/quran/sura_details_screen.dart';
import '../../../core/theme/app_colors.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  final PageController _pageController = PageController(viewportFraction: 0.93);
  int _currentRecentIndex = 0;

  String searchQuery = "";
  List<Map<String, dynamic>> allSuras = [];
  List<Map<String, dynamic>> filteredSuras = [];

  final List<Map<String, String>> recentSuras = [
    {"en": "Al-Anbiya", "ar": "الأنبياء", "verses": "112"},
    {"en": "Al-Fatiha", "ar": "الفاتحه", "verses": "7"},
  ];

  List<String> arabicAuranSuras = [
    "الفاتحه", "البقرة", "آل عمران", "النساء", "المائدة", "الأنعام", "الأعراف", "الأنفال", "التوبة", "يونس", "هود",
    "يوسف", "الرعد", "إبراهيم", "الحجر", "النحل", "الإسراء", "الكهف", "مريم", "طه", "الأنبياء", "الحج", "المؤمنون",
    "النّور", "الفرقان", "الشعراء", "النّمل", "القصص", "العنكبوت", "الرّوم", "لقمان", "السجدة", "الأحزاب", "سبأ",
    "فاطر", "يس", "الصافات", "ص", "الزمر", "غافر", "فصّلت", "الشورى", "الزخرف", "الدّخان", "الجاثية", "الأحقاف",
    "محمد", "الفتح", "الحجرات", "ق", "الذاريات", "الطور", "النجم", "القمر", "الرحمن", "الواقعة", "الحديد", "المجادلة",
    "الحشر", "الممتحنة", "الصف", "الجمعة", "المنافقون", "التغابن", "الطلاق", "التحريم", "الملك", "القلم", "الحاقة",
    "المعارج", "نوح", "الجن", "المزّمّل", "المدّثر", "القيامة", "الإنسان", "المرسلات", "النبأ", "النازعات", "عبس",
    "التكوير", "الإنفطار", "المطفّفين", "الإنشقاق", "البروج", "الطارق", "الأعلى", "الغاشية", "الفجر", "البلد", "الشمس",
    "الليل", "الضحى", "الشرح", "التين", "العلق", "القدر", "البينة", "الزلزلة", "العاديات", "القارعة", "التكاثر",
    "العصر", "الهمزة", "الفيل", "قريش", "الماعون", "الكوثر", "الكافرون", "النصر", "المسد", "الإخلاص", "الفلق", "الناس"
  ];

  List<String> englishQuranSurahs = [
    "Al-Fatiha", "Al-Baqarah", "Aal-E-Imran", "An-Nisa'", "Al-Ma'idah", "Al-An'am", "Al-A'raf", "Al-Anfal", "At-Tawbah",
    "Yunus", "Hud", "Yusuf", "Ar-Ra'd", "Ibrahim", "Al-Hijr", "An-Nahl", "Al-Isra", "Al-Kahf", "Maryam", "Ta-Ha",
    "Al-Anbiya", "Al-Hajj", "Al-Mu'minun", "An-Nur", "Al-Furqan", "Ash-Shu'ara", "An-Naml", "Al-Qasas", "Al-Ankabut",
    "Ar-Rum", "Luqman", "As-Sajda", "Al-Ahzab", "Saba", "Fatir", "Ya-Sin", "As-Saffat", "Sad", "Az-Zumar", "Ghafir",
    "Fussilat", "Ash-Shura", "Az-Zukhruf", "Ad-Dukhan", "Al-Jathiya", "Al-Ahqaf", "Muhammad", "Al-Fath", "Al-Hujurat",
    "Qaf", "Adh-Dhariyat", "At-Tur", "An-Najm", "Al-Qamar", "Ar-Rahman", "Al-Waqi'a", "Al-Hadid", "Al-Mujadila",
    "Al-Hashr", "Al-Mumtahina", "As-Saff", "Al-Jumu'a", "Al-Munafiqun", "At-Taghabun", "At-Talaq", "At-Tahrim",
    "Al-Mulk", "Al-Qalam", "Al-Haqqah", "Al-Ma'arij", "Nuh", "Al-Jinn", "Al-Muzzammil", "Al-Muddathir", "Al-Qiyamah",
    "Al-Insan", "Al-Mursalat", "An-Naba'", "An-Nazi'at", "Abasa", "At-Takwir", "Al-Infitar", "Al-Mutaffifin",
    "Al-Inshiqaq", "Al-Buruj", "At-Tariq", "Al-A'la", "Al-Ghashiyah", "Al-Fajr", "Al-Balad", "Ash-Shams", "Al-Lail",
    "Ad-Duha", "Ash-Sharh", "At-Tin", "Al-Alaq", "Al-Qadr", "Al-Bayyina", "Az-Zalzalah", "Al-Adiyat", "Al-Qari'a",
    "At-Takathur", "Al-Asr", "Al-Humazah", "Al-Fil", "Quraysh", "Al-Ma'un", "Al-Kawthar", "Al-Kafirun", "An-Nasr",
    "Al-Masad", "Al-Ikhlas", "Al-Falaq", "An-Nas"
  ];

  List<String> ayaNumber = [
    '7', '286', '200', '176', '120', '165', '206', '75', '129', '109', '123', '111', '43', '52', '99', '128', '111',
    '110', '98', '135', '112', '78', '118', '64', '77', '227', '93', '88', '69', '60', '34', '30', '73', '54', '45',
    '83', '182', '88', '75', '85', '54', '53', '89', '59', '37', '35', '38', '29', '18', '45', '60', '49', '62', '55',
    '78', '96', '29', '22', '24', '13', '14', '11', '11', '18', '12', '12', '30', '52', '52', '44', '28', '28', '20',
    '56', '40', '31', '50', '40', '46', '42', '29', '19', '36', '25', '22', '17', '19', '26', '30', '20', '15', '21',
    '11', '8', '5', '19', '5', '8', '8', '11', '11', '8', '3', '9', '5', '4', '6', '3', '6', '3', '5', '4', '5', '6'
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < arabicAuranSuras.length; i++) {
      allSuras.add({
        'originalIndex': i,
        'ar': arabicAuranSuras[i],
        'en': englishQuranSurahs[i],
        'verses': ayaNumber[i],
      });
    }
    filteredSuras = allSuras;
  }

  void onSearchTextChanged(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredSuras = allSuras;
      } else {
        filteredSuras = allSuras.where((sura) {
          return sura['ar'].contains(query) ||
              sura['en'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/taj-mahal-agra-india.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withValues(alpha: 0.6)),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/Mosque-01.png', height: 150, width: double.infinity, fit: BoxFit.cover),
                    Image.asset('assets/images/Islami.png', height: 50),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  onChanged: onSearchTextChanged,
                  decoration: InputDecoration(
                    hintText: "Sura Name",
                    hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    prefixIcon: const Icon(Icons.menu_book, color: AppColors.primaryGold, size: 28),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppColors.primaryGold, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppColors.primaryGold, width: 2.5),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (searchQuery.isEmpty) ...[
                  const Text("Most Recently", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: recentSuras.length,
                      onPageChanged: (index) {
                        setState(() { _currentRecentIndex = index; });
                      },
                      itemBuilder: (context, index) {
                        return buildRecentSuraCard(
                          arabicName: recentSuras[index]['ar']!,
                          englishName: recentSuras[index]['en']!,
                          versesCount: recentSuras[index]['verses']!,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      recentSuras.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentRecentIndex == index ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentRecentIndex == index ? AppColors.primaryGold : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text("Suras List", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                ],
                Expanded(
                  child: filteredSuras.isEmpty
                      ? const Center(child: Text("No Sura Found", style: TextStyle(color: AppColors.primaryGold, fontSize: 20, fontWeight: FontWeight.bold)))
                      : ListView.separated(
                    itemCount: filteredSuras.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.white,
                      thickness: 1.5,
                      indent: 40,
                      endIndent: 40,
                    ),
                    itemBuilder: (context, index) {
                      final sura = filteredSuras[index];
                      return buildSuraItem(
                        index: sura['originalIndex'],
                        arabicName: sura['ar'],
                        englishName: sura['en'],
                        versesCount: sura['verses'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRecentSuraCard({required String arabicName, required String englishName, required String versesCount}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.primaryGold,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(englishName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
              Text(arabicName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
              Text("$versesCount Verses", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black)),
            ],
          ),
          Image.asset('assets/images/quranSura.png', height: 80),
        ],
      ),
    );
  }

  Widget buildSuraItem({required int index, required String arabicName, required String englishName, required String versesCount}) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuraDetailsScreen(
              suraIndex: index + 1,
              arabicName: arabicName,
              englishName: englishName,
            ),
          ),
        );
      },
      leading: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.star_border, color: AppColors.whiteColor, size: 50),
          Text(
            "${index + 1}",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
      title: Text(
        englishName,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        "$versesCount Verses",
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
      ),
      trailing: Text(
        arabicName,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}