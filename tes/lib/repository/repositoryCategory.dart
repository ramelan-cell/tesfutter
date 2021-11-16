import 'package:tes/model/category.dart';
import 'package:tes/provider/apiproviderCategory.dart';

class RepositoryCategory {
  final apiProviderCategory = ApiProviderCategory();

  Future<List<Categories>> fetchAllCategory() =>
      apiProviderCategory.fetchCategory();
}
