import 'package:flutter/material.dart';
import 'package:my_unit_converter/screen/exchange_app.dart';

class Backdrop extends StatefulWidget {
  final Widget backdrop;
  final Widget panel;
  final String backdropTitlePanelOff;
  final String backdropTitlePanelOn;
  final String panelTitle;
  final Color backTitleColor;

  const Backdrop({
    @required this.backdrop,
    @required this.panel,
    @required this.backdropTitlePanelOff,
    @required this.panelTitle,
    @required this.backdropTitlePanelOn,
    @required this.backTitleColor,
  });

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final _anmiationPanel =
      RelativeRectTween(begin: RelativeRect.fill, end: RelativeRect.fill);
  final double _panelTitleHeight = 60.0;
  final double _dividerHeight = 1.0;

  AnimationController _controller;
  bool isPanelUp = true; // default up
  double _dyStart = 0;
  double _dyMove = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: 0, vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Always go up again when user choose category.
    _controller.fling(velocity: -1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: _toggleOnOffPane,
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller,
            )),
        title: _buildBackTitle(),
        backgroundColor: widget.backTitleColor,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          _anmiationPanel
            ..end = RelativeRect.fromLTRB(0,
                constraints.maxHeight - _panelTitleHeight, 0, -_dividerHeight);

          return Stack(
            children: <Widget>[widget.backdrop, _buildPanel()],
          );
        },
      ),
    );
  }

  void _toggleOnOffPane() {
    if (isPanelUp)
      _movePanelDown();
    else
      _movePanelUp();
  }

  void _hidePanelCallback() {
    InheritedHidePanelCallback.of(context).hidePanelCallback();
  }

  Widget _buildPanelTitle() => InkWell(
        onTap: () {
          _toggleOnOffPane();
        },
        child: Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints.expand(height: _panelTitleHeight),
            child: Text(widget.panelTitle, style: TextStyle(fontSize: 25))),
      );

  void _movePanelUp() {
    _controller.fling(velocity: -1);
    _hidePanelCallback();
    isPanelUp = true;
  }

  void _movePanelDown() {
    _controller.fling(velocity: 1);
    _hidePanelCallback();
    isPanelUp = false;
  }

  void _onDragStart(DragStartDetails dragStart) {
    _dyStart = dragStart.localPosition.dy;
  }

  void _countDyMove(DragUpdateDetails dragUpdateDetails) {
    _dyMove = (_dyStart - dragUpdateDetails.localPosition.dy) * 0.001;
  }

  void _moveUpWhenSmallerThan(double value) {
    print('CONTROL VALUE ' + _controller.value.toString());
    if (_controller.value < value)
      _movePanelUp();
    else
      _movePanelDown();
  }

  Widget _wrapDragBehavior(Widget child) {
    return GestureDetector(
      onVerticalDragStart: _onDragStart,
      onVerticalDragEnd: (dragEndDetail) {
        _moveUpWhenSmallerThan(0.05);
      },
      onVerticalDragUpdate: (DragUpdateDetails dragUpdate) {
        _countDyMove(dragUpdate);
        _controller.value = -_dyMove;
      },
      child: child,
    );
  }

  Widget _wrapPanelTitleDragBehavior(Widget child) {
    return GestureDetector(
      onVerticalDragStart: _onDragStart,
      onVerticalDragEnd: (dragEndDetail) {
        if (isPanelUp)
          _moveUpWhenSmallerThan(0.05);
        else
          _moveUpWhenSmallerThan(0.95);
      },
      onVerticalDragUpdate: (DragUpdateDetails dragUpdate) {
        _countDyMove(dragUpdate);
        if (isPanelUp)
          _controller.value = -_dyMove;
        else
          _controller.value = 1 - _dyMove;
      },
      child: child,
    );
  }

  Widget _buildPanel() => PositionedTransition(
        rect: _anmiationPanel.animate(_controller),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            children: <Widget>[
              _wrapPanelTitleDragBehavior(_buildPanelTitle()),
              Divider(
                height: _dividerHeight,
              ),
              Expanded(child: _wrapDragBehavior(widget.panel))
            ],
          ),
        ),
      );

  AnimatedWidget _buildBackTitle() {
    return AnimatedBuilder(
      builder: (context, child) => Stack(
        children: <Widget>[
          Opacity(
            opacity: CurvedAnimation(
                    parent: ReverseAnimation(_controller),
                    curve: Interval(0.5, 1))
                .value,
            child: Text(widget.backdropTitlePanelOn),
          ),
          Opacity(
            opacity:
                CurvedAnimation(parent: _controller, curve: Interval(0.5, 1))
                    .value,
            child: Text(widget.backdropTitlePanelOff),
          )
        ],
      ),
      animation: _controller,
    );
  }
}
