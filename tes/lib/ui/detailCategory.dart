import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/model/favorite.dart';
import 'package:tes/model/meals.dart';
import 'package:tes/provider/favorite.dart';
import 'package:tes/ui/favorite.dart';

class DetailCategory extends StatefulWidget {
  String strcategory;
  DetailCategory({this.strcategory});
  @override
  _DetailCategoryState createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  static int page;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List categories = new List();
  final dio = new Dio();

  getPref() async {
    this._getMoreData(widget.strcategory);

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _getMoreData(widget.strcategory);
      }
    });

    searchController.addListener(() {
      if (this.mounted) {
        setState(() {
          filter = searchController.text;
        });
      }
    });
  }

  @override
  void initState() {
    if (this.mounted) {
      setState(() {
        super.initState();
        getPref();
      });
    }
  }

  @override
  void dispose() {
    if (this.mounted) {
      super.dispose();
      _sc.dispose();
      searchController.dispose();
    }
  }

  TextEditingController searchController = new TextEditingController();
  String filter;

  Future<void> _addItemtoOrderList(
      {ProviderFavorite providerFavorite, Meals meals}) async {
    providerFavorite.addCart(meals: meals);
  }

  @override
  Widget build(BuildContext context) {
    final providerlistState =
        Provider.of<ProviderFavorite>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food",
            style: TextStyle(fontSize: 16.0, color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DataFavorite()));
            },
            icon: _buildIconBadge(Icons.inbox,
                providerlistState.favorite.length.toString(), Colors.red),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                new Padding(
                  padding: new EdgeInsets.all(8.0),
                  child: new TextField(
                    style: TextStyle(fontSize: 13.0, color: Colors.black),
                    controller: searchController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      hintText: 'Pencarian berdasarkan meals ...',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ),
                ),
                new Expanded(
                  child: _buildList(),
                ),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildList() {
    var providerFavorite =
        Provider.of<ProviderFavorite>(context, listen: false);
    return ListView.builder(
      shrinkWrap: true,
      itemCount:
          categories.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == categories.length) {
          return _buildProgressIndicator();
        } else {
          return filter == null || filter == ""
              ? Card(
                  child: ListTile(
                    trailing: OutlineButton(
                      textColor: Colors.green,
                      onPressed: () {
                        _addItemtoOrderList(
                            meals: categories[index],
                            providerFavorite: providerFavorite);
                      },
                      child: Text('ADD'),
                    ),
                    leading: Image.network(categories[index].strMealThumb),
                    title: Text(categories[index].strMeal),
                  ),
                )
              : categories[index]
                      .strMeal
                      .toLowerCase()
                      .contains(filter.toLowerCase())
                  ? Card(
                      child: ListTile(
                        trailing: OutlineButton(
                          textColor: Colors.green,
                          onPressed: () {
                            _addItemtoOrderList(
                                meals: categories[index],
                                providerFavorite: providerFavorite);
                          },
                          child: Text('ADD'),
                        ),
                        leading: Image.network(categories[index].strMealThumb),
                        title: Text(categories[index].strMeal),
                      ),
                    )
                  : Container();
        }
      },
      controller: _sc,
    );
  }

  void _getMoreData(String category) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      var url =
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=" + category;

      final response = await dio.get(url);
      if (response.statusCode == 200) {
        ListMeals listmeals = ListMeals.fromJson(response.data);
        List<Meals> meals = List();
        for (int i = 0; i < listmeals.meals.length; i++) {
          var listmeal = Meals(
              idMeal: listmeals.meals[i].idMeal.toString(),
              strMeal: listmeals.meals[i].strMeal,
              strMealThumb: listmeals.meals[i].strMealThumb);

          meals.add(listmeal);
        }

        setState(() {
          isLoading = false;
          categories.addAll(meals);
        });
      }

      // List tList = new List();

      // for (int i = 0; i < data['results'].length; i++) {
      //   tList.add(data['results'][i]);
      // }

    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}

Widget _buildIconBadge(
  IconData icon,
  String badgeText,
  Color badgeColor,
) {
  return Stack(
    children: <Widget>[
      Icon(
        icon,
        size: 30.0,
      ),
      Positioned(
        top: 2.0,
        right: 2.0,
        child: Container(
          padding: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
            color: badgeColor,
            shape: BoxShape.circle,
          ),
          constraints: BoxConstraints(
            minWidth: 18.0,
            minHeight: 18.0,
          ),
          child: Center(
            child: Text(
              badgeText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
