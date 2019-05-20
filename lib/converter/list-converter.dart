import 'package:flutter/material.dart';

class ListConverter extends StatelessWidget {
  final _data = <DataItemConverter>[
    DataItemConverter(title: 'Area', iconPath: 'assets/icons/area.png'),
    DataItemConverter(title: 'Currency', iconPath: 'assets/icons/currency.png'),
    DataItemConverter(title: 'Length', iconPath: 'assets/icons/length.png'),
    DataItemConverter(title: 'Mass', iconPath: 'assets/icons/mass.png'),
    DataItemConverter(title: 'Power', iconPath: 'assets/icons/power.png'),
    DataItemConverter(title: 'Time', iconPath: 'assets/icons/time.png'),
    DataItemConverter(title: 'Volume', iconPath: 'assets/icons/volume.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ItemConverter(data: _data[index]);
        },
      ),
    );
  }
}

class ItemConverter extends StatelessWidget {
  final DataItemConverter data;

  const ItemConverter({@required this.data}) : assert(data != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Image.asset(
              data.iconPath,
            ),
          ),
          Text(
            data.title,
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}

class DataItemConverter {
  String title;
  String iconPath;

  DataItemConverter({this.title, this.iconPath});
}
