import 'package:flutter/cupertino.dart';
import 'package:tes/model/favorite.dart';
import 'package:tes/model/meals.dart';

class ProviderFavorite with ChangeNotifier {
  List<Favorite> favorite = List();

  void removeFromList(int index) {
    favorite.removeAt(index);
    notifyListeners();
  }

  void addCart({Meals meals}) {
    int index = favorite.indexWhere((data) {
      return data.strMeal == meals.strMeal && data.idMeal == meals.idMeal;
    });

    if (index == -1) {
      favorite.add(Favorite(
          idMeal: meals.idMeal,
          strMeal: meals.strMeal,
          qty: 1,
          strMealThumb: meals.strMealThumb));
    } else {
      int prevQty = favorite[index].qty;

      favorite[index] = Favorite(
          idMeal: meals.idMeal,
          strMeal: meals.strMeal,
          qty: prevQty + 1,
          strMealThumb: meals.strMealThumb);
    }

    notifyListeners();
  }
}
