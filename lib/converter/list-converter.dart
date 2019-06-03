import 'package:flutter/material.dart';

class ListConverter extends StatefulWidget {
  final VoidCallback onItemTap;

  const ListConverter({this.onItemTap});

  @override
  _ListConverterState createState() => _ListConverterState();
}

class _ListConverterState extends State<ListConverter> {
  final _data = <DataItemConverter>[
    DataItemConverter(
        title: 'Area', iconPath: 'assets/icons/area.png', color: Colors.blue),
    DataItemConverter(
        title: 'Currency',
        iconPath: 'assets/icons/currency.png',
        color: Colors.pink),
    DataItemConverter(
        title: 'Length',
        iconPath: 'assets/icons/length.png',
        color: Colors.greenAccent),
    DataItemConverter(
        title: 'Mass', iconPath: 'assets/icons/mass.png', color: Colors.green),
    DataItemConverter(
        title: 'Power',
        iconPath: 'assets/icons/power.png',
        color: Colors.indigo),
    DataItemConverter(
        title: 'Time', iconPath: 'assets/icons/time.png', color: Colors.lime),
    DataItemConverter(
        title: 'Volume',
        iconPath: 'assets/icons/volume.png',
        color: Colors.orange),
  ];

  DataItemConverter _currentConverter;

  @override
  void initState() {
    super.initState();
    _currentConverter = _data[0];
  }

  @override
  void didUpdateWidget(ListConverter oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('listconverter didUpdate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentConverter.color,
      body: ListView.builder(
          padding: EdgeInsets.only(bottom: 40),
          itemCount: _data.length,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  print('OIT InkWell');
                  widget.onItemTap();
                  setState(() {
                    _currentConverter = _data[index];
                  });
                },
                child: ItemConverter(data: _data[index]),
              )),
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
            padding: EdgeInsets.all(25),
            child: Image.asset(
              data.iconPath,
            ),
          ),
          Text(
            data.title,
            style: TextStyle(fontSize: 35),
          ),
        ],
      ),
    );
  }
}

class DataItemConverter {
  String title;
  String iconPath;
  Color color;

  DataItemConverter(
      {@required this.title, @required this.iconPath, @required this.color});
}
