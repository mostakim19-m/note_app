
class NotesModel {
  final String title;
  final String description;
  final DateTime createdDate;
  final DateTime? updateDate;

  NotesModel({required this.title, required this.description,
    required this.createdDate, this.updateDate,});
}