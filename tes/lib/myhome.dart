import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tes/bloc/blocCategory.dart';
import 'package:tes/ui/detailCategory.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Timer _timer;
  @override
  void initState() {
    blocCategory.BlocfetchAllCategory();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      blocCategory.BlocfetchAllCategory();
    });
    super.initState();
  }

  @override
  void dispose() {
    blocCategory.dispose();
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Makanan'),
      ),
      body: Scrollbar(
        child: StreamBuilder(
          stream: blocCategory.semuaDataCategory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        trailing: OutlineButton(
                          textColor: Colors.green,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailCategory(
                                      strcategory: snapshot.data[i].strCategory,
                                    )));
                          },
                          child: Text('Lihat detail'),
                        ),
                        leading:
                            Image.network(snapshot.data[i].strCategoryThumb),
                        title: Text(snapshot.data[i].strCategory),
                      ),
                    );
                  });
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
