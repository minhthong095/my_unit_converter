import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_unit_converter/bloc/change_category/bloc_change_category.dart';
import 'package:my_unit_converter/bloc/change_category/event_change_category.dart';
import 'package:my_unit_converter/model_response/model_backdrop_response.dart';

class ListConverter extends StatefulWidget {
  final List<ModelBackdropResponse> data;
  final ModelBackdropResponse cateogry;

  const ListConverter({@required this.cateogry, this.data});

  @override
  _ListConverterState createState() => _ListConverterState();
}

class _ListConverterState extends State<ListConverter> {
  BlocChangeCategory _blocCategory;

  @override
  void initState() {
    _blocCategory = BlocProvider.of<BlocChangeCategory>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("BUILD LIST CONVERTER");
    return Scaffold(
      backgroundColor: widget.cateogry.color,
      body: ListView.builder(
          padding: EdgeInsets.only(bottom: 40),
          itemCount: widget.data.length,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  _blocCategory.add(EventChange(index: index));
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
