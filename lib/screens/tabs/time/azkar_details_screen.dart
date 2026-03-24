import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/azkar_model.dart';

class AzkarDetailsScreen extends StatefulWidget {
  final String categoryName;

  const AzkarDetailsScreen({super.key, required this.categoryName});

  @override
  State<AzkarDetailsScreen> createState() => _AzkarDetailsScreenState();
}

class _AzkarDetailsScreenState extends State<AzkarDetailsScreen> {
  List<AzkarModel> azkarList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAzkarData();
  }

  Future<void> loadAzkarData() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/azkar.json');
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      if (jsonData.containsKey(widget.categoryName)) {
        List<dynamic> categoryData = jsonData[widget.categoryName];

        for (var item in categoryData) {
          if (item is Map<String, dynamic>) {
            azkarList.add(AzkarModel.fromJson(item));
          } else if (item is List) {
            for (var innerItem in item) {
              if (innerItem is Map<String, dynamic>) {
                azkarList.add(AzkarModel.fromJson(innerItem));
              }
            }
          }
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
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
          widget.categoryName,
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
              'assets/images/Mosque-02 2.png',
              fit: BoxFit.cover,
            ),
          ),
          isLoading
              ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGold))
              : azkarList.isEmpty
              ? const Center(
              child: Text("لا توجد أذكار",
                  style: TextStyle(color: Colors.white, fontSize: 20)))
              : ListView.builder(
            padding: const EdgeInsets.only(
                bottom: 120, top: 20, left: 16, right: 16),
            itemCount: azkarList.length,
            itemBuilder: (context, index) {
              return buildZekrCard(azkarList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget buildZekrCard(AzkarModel zekr) {
    String cleanContent = zekr.content
        .replaceAll('\\n\', \'', '')
        .replaceAll('\'', '')
        .replaceAll('\\n', '')
        .trim();

    if (cleanContent == "stop") return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryGold,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            cleanContent,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.8,
            ),
          ),
          if (zekr.description.isNotEmpty) ...[
            const Divider(color: Colors.black38),
            Text(
              zekr.description,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ],
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              "التكرار: ${zekr.count}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}