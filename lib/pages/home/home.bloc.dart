import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_dev_saham_rakyat/models/meal.model.dart';
import 'package:mobile_dev_saham_rakyat/pages/home/home.event.dart';
import 'package:mobile_dev_saham_rakyat/pages/home/home.state.dart';
import 'package:mobile_dev_saham_rakyat/services/meal.service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<OnLoadHome>(_onLoadHome);
    on<OnSelectCategory>(_onSelectCategory);
  }
  void _onLoadHome(OnLoadHome event, Emitter<HomeState> emit) async {
    try {
      emit(state.copy(isLoading: true, isFailed: false));

      Response response = await MealService.getCategories();

      List<String> categories = [];
      for (dynamic category in response.data['meals']) {
        categories.add(category['strCategory']);
      }
      emit(state.copy(isLoading: false, categories: categories));
    } catch (e) {
      emit(state.copy(isLoading: false, isFailed: true));
    }
  }

  void _onSelectCategory(OnSelectCategory event, Emitter<HomeState> emit) async {
    try {
      emit(state.copy(selectedCategory: event.category, isMealLoading: true, isMealFailed: false));

      Response response = await MealService.getMeals(category: event.category);

      List<Meal> meals = [];
      for (dynamic meal in response.data['meals']) {
        meals.add(Meal(
          id: meal['idMeal'],
          title: meal['strMeal'],
          pictureUrl: meal['strMealThumb'],
        ));
      }

      emit(state.copy(isMealLoading: false, meals: meals));
    } catch (e) {
      emit(state.copy(isMealLoading: false, isMealFailed: true));
    }
  }
}
