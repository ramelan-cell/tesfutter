import 'package:rxdart/rxdart.dart';
import 'package:tes/model/category.dart';
import 'package:tes/repository/repositoryCategory.dart';

class BlocCategory {
  // Variabel tampil data Category
  final _respositoryCategory = RepositoryCategory();
  final _fetchCategory = PublishSubject<List<Categories>>();

  Observable<List<Categories>> get semuaDataCategory => _fetchCategory.stream;

  // ignore: non_constant_identifier_names
  BlocfetchAllCategory() async {
    List<Categories> listCategory =
        await _respositoryCategory.fetchAllCategory();
    _fetchCategory.sink.add(listCategory);
  }

  dispose() {
    _fetchCategory.close();
  }
}

final blocCategory = BlocCategory(); // variabel global bair bisa pakai dimana2
