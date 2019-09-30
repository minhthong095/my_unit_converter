import 'package:flutter/material.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';

class ListConverter extends StatefulWidget {
  final List<ModelBackdropResponse> data;
  final int defaultIndex;
  final Function onItemTap;

  const ListConverter(
      {@required this.data, this.defaultIndex = 0, this.onItemTap});

  @override
  _ListConverterState createState() => _ListConverterState();
}

class _ListConverterState extends State<ListConverter> {
  ModelBackdropResponse _currentConverter;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _currentConverter = widget.data[widget.defaultIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentConverter.color,
      body: ListView.builder(
          padding: EdgeInsets.only(bottom: 40),
          itemCount: widget.data.length,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  widget.onItemTap(index);
                  setState(() {
                    _currentConverter = widget.data[index];
                  });
                },
                child: ItemConverter(data: widget.data[index]),
              )),
    );
  }
}

class ItemConverter extends StatelessWidget {
  final ModelBackdropResponse data;

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
              data.iconCode,
            ),
          ),
          Text(
            data.title,
            style: TextStyle(fontSize: 28),
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
