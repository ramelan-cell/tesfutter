import 'dart:math';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tambah Favorite'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.network(
                    'https://www.themealdb.com/images/media/meals/qysyss1511558054.jpg'),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 14, 0, 16),
                  child: Text('descripsi')),
              Text('Ingredients:'),
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 0, 41),
                child: Text('tesss'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 163,
                      height: 45,
                      child: RaisedButton(
                          onPressed: () {
                            //
                          },
                          color: Colors.orange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text('Order Now')))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
