class Favorite {
  String strMeal;
  String strMealThumb;
  String idMeal;
  int qty;

  Favorite({this.strMeal, this.strMealThumb, this.idMeal, this.qty});

  Favorite.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['strMeal'] = this.strMeal;
    data['strMealThumb'] = this.strMealThumb;
    data['idMeal'] = this.idMeal;
    data['qty'] = this.qty;
    return data;
  }
}
