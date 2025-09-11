import '../models/category_model.dart';
import '../services/api_service.dart';

class CategoryRepository {
  final ApiService api;

  CategoryRepository(this.api);

  Future<List<CategoryModel>> fetchCategories() async {
    final data = await api.get();
    return data.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
  }
}
