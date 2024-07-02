class DiaryModel {
  final String id;
  final String title;
  final String content;
  final String date;

  DiaryModel({required this.id, required this.title, required this.content, required this.date});

  factory DiaryModel.fromJson(Map<String, dynamic> json) {
    return DiaryModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }
}
