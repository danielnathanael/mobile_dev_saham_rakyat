import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class OnLoadHome extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class OnSelectCategory extends HomeEvent {
  final String category;

  OnSelectCategory({required this.category});

  @override
  List<Object?> get props => [category];
}
