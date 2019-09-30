import 'package:flutter/widgets.dart';

abstract class EventChangeCategory {}

class EventChange extends EventChangeCategory {
  final index;
  EventChange({@required this.index});
}
