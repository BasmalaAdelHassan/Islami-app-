class AzkarModel {
  final String category;
  final String count;
  final String description;
  final String reference;
  final String content;

  AzkarModel({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.content,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      category: json['category'] ?? "",
      count: json['count'] ?? "",
      description: json['description'] ?? "",
      reference: json['reference'] ?? "",
      content: json['content'] ?? "",
    );
  }
}