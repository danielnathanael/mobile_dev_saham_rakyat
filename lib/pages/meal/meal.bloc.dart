import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_dev_saham_rakyat/models/meal.model.dart';
import 'package:mobile_dev_saham_rakyat/pages/meal/meal.event.dart';
import 'package:mobile_dev_saham_rakyat/pages/meal/meal.state.dart';
import 'package:mobile_dev_saham_rakyat/services/meal.service.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(MealState()) {
    on<OnLoadMeal>(_onLoadMeal);
  }

  void _onLoadMeal(OnLoadMeal event, Emitter<MealState> emit) async {
    try {
      emit(state.copy(isLoading: true, isFailed: false));

      Response response = await MealService.getMeal(id: event.id);

      List<String> tags = [];
      for (String tag in response.data['meals'][0]['strTags'].toString().split(',')) {
        tags.add(tag.trim());
      }

      // VERY BAD API RESPONSE FOR INGREDIENTS, SHOULD BE FIXED
      List<String> ingredients = [];
      int maxCount = 20; //Maximum API JSON response for ingredients

      for (int i = 1; i <= maxCount; i++) {
        String attribute = 'strIngredient$i';
        if (response.data['meals'][0][attribute] != null &&
            response.data['meals'][0][attribute].toString().isNotEmpty) {
          ingredients.add(response.data['meals'][0][attribute]);
        }
      }

      Meal meal = Meal(
        id: response.data['meals'][0]['idMeal'],
        title: response.data['meals'][0]['strMeal'],
        pictureUrl: response.data['meals'][0]['strMealThumb'],
        tags: tags,
        ingredients: ingredients,
      );

      emit(state.copy(isLoading: false, meal: meal));
    } catch (e) {
      emit(state.copy(isLoading: false, isFailed: true));
    }
  }
}
