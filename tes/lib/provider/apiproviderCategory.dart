import 'dart:convert';

import 'package:http/http.dart';
import 'package:tes/model/category.dart';

class ApiProviderCategory {
  Client client = Client();

  Future<List<Categories>> fetchCategory() async {
    var resullt = await client
        .get("https://www.themealdb.com/api/json/v1/1/categories.php");
    var dataCategory = jsonDecode(resullt.body);
    ModelCategory modelCategory = ModelCategory.fromJson(dataCategory);

    List<Categories> listCategory = List();

    for (int i = 0; i < modelCategory.categories.length; i++) {
      var listmodelCategory = Categories(
          idCategory: modelCategory.categories[i].idCategory,
          strCategory: modelCategory.categories[i].strCategory,
          strCategoryThumb: modelCategory.categories[i].strCategoryThumb,
          strCategoryDescription:
              modelCategory.categories[i].strCategoryDescription);

      var id = int.parse(modelCategory.categories[i].idCategory);
      listmodelCategory.SetIdCategory(modelCategory.categories[i].idCategory);

      listCategory.add(listmodelCategory);
    }

    return listCategory;
  }
}
