import 'package:equatable/equatable.dart';

abstract class MealEvent extends Equatable {}

class OnLoadMeal extends MealEvent {
  final String id;

  OnLoadMeal({required this.id});

  @override
  List<Object?> get props => [id];
}
