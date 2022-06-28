import 'package:equatable/equatable.dart';
import 'package:mobile_dev_saham_rakyat/models/meal.model.dart';

class MealState extends Equatable {
  final Meal? meal;

  final bool isLoading;
  final bool isFailed;

  const MealState({
    this.meal,
    this.isLoading = false,
    this.isFailed = false,
  });

  MealState copy({
    Meal? meal,
    bool? isLoading,
    bool? isFailed,
    List<Meal>? meals,
    bool? isMealLoading,
    bool? isMealFailed,
  }) {
    return MealState(
      meal: meal ?? this.meal,
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
    );
  }

  @override
  List<Object?> get props => [
        meal,
        isLoading,
        isFailed,
      ];
}
