import 'package:flutter/foundation.dart';

abstract class EventExchangeApp {
  const EventExchangeApp();
}

class Init extends EventExchangeApp {
  final Map<String, dynamic> tempBodyForConversion;

  const Init({@required this.tempBodyForConversion}) : super();
}
