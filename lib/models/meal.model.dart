import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String id;
  final String title;
  final String pictureUrl;
  final List<String>? tags;
  final String? youtubeUrl;
  final List<String>? ingredients;

  const Meal({
    required this.id,
    required this.title,
    required this.pictureUrl,
    this.tags,
    this.youtubeUrl,
    this.ingredients,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        pictureUrl,
      ];
}
