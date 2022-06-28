import 'package:dio/dio.dart';

class MealService {
  static const baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  static Future<Response> getCategories() async {
    Response response = await Dio().get('$baseUrl/list.php?c=list');
    return response;
  }

  static Future<Response> getMeals({required String category}) async {
    Response response = await Dio().get('$baseUrl/filter.php?c=$category');
    return response;
  }

  static Future<Response> getMeal({required String id}) async {
    Response response = await Dio().get('$baseUrl/lookup.php?i=$id');
    return response;
  }
}
