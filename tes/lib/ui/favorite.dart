import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tes/provider/favorite.dart';

class DataFavorite extends StatefulWidget {
  @override
  _DataFavoriteState createState() => _DataFavoriteState();
}

class _DataFavoriteState extends State<DataFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Favorite'),
      ),
      body: Container(
        child: Consumer<ProviderFavorite>(
          builder: (context, providerlistState, _) => ListView.builder(
              shrinkWrap: true,
              itemCount: providerlistState.favorite.length,
              itemBuilder: (context, index) {
                var favoriteList = providerlistState.favorite;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new ListTile(
                      leading: Image.network(favoriteList[index].strMealThumb),
                      subtitle: Text(
                          'Jumlah : ' + favoriteList[index].qty.toString()),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 250,
                            child: Text(favoriteList[index].strMeal,
                                style: GoogleFonts.poppins().copyWith(
                                    color: Colors.black, fontSize: 12.0)),
                          ),
                          GestureDetector(
                            onTap: () {
                              providerlistState.removeFromList(index);
                            },
                            child: Icon(
                              Icons.cancel_sharp,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
