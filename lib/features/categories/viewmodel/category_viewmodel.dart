import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/category_model.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/services/api_service.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final api = ApiService(
    'https://api.jsonbin.io/v3/b/68c1656c43b1c97be93db48e',
  );
  return CategoryRepository(api);
});

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, AsyncValue<List<CategoryModel>>>(
  (ref) {
    final repo = ref.watch(categoryRepositoryProvider);
    return CategoryViewModel(repo);
  },
);

class CategoryViewModel extends StateNotifier<AsyncValue<List<CategoryModel>>> {
  final CategoryRepository repository;

  CategoryViewModel(this.repository) : super(const AsyncLoading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncLoading();
    try {
      final list = await repository.fetchCategories();
      state = AsyncValue.data(list);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> reload() async => loadCategories();
}
