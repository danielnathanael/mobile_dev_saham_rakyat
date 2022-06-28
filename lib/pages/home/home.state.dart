import 'package:equatable/equatable.dart';
import 'package:mobile_dev_saham_rakyat/models/meal.model.dart';

class HomeState extends Equatable {
  final List<String> categories;
  final String? selectedCategory;

  final bool isLoading;
  final bool isFailed;

  final List<Meal> meals;
  final bool isMealLoading;
  final bool isMealFailed;

  const HomeState({
    this.categories = const [],
    this.selectedCategory,
    this.isLoading = false,
    this.isFailed = false,
    this.meals = const [],
    this.isMealLoading = false,
    this.isMealFailed = false,
  });

  HomeState copy({
    List<String>? categories,
    String? selectedCategory,
    bool? isLoading,
    bool? isFailed,
    List<Meal>? meals,
    bool? isMealLoading,
    bool? isMealFailed,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      meals: meals ?? this.meals,
      isMealLoading: isMealLoading ?? this.isMealLoading,
      isMealFailed: isMealFailed ?? this.isMealFailed,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        selectedCategory,
        isLoading,
        isFailed,
        meals,
        isMealLoading,
        isMealFailed,
      ];
}
