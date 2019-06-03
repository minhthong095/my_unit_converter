import 'package:flutter/material.dart';
import 'package:my_unit_converter/converter/converter.dart';
import 'dart:math' as math;

class Backdrop extends StatefulWidget {
  final Widget backdrop;
  final Widget panel;
  final bool panelVisible;
  final String backdropTitle;
  final String panelTitle;

  const Backdrop(
      {@required this.backdrop,
      @required this.panel,
      @required this.backdropTitle,
      @required this.panelTitle,
      this.panelVisible = true});

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
  bool test = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: widget.panelVisible ? 0 : 1,
        vsync: this,
        duration: Duration(seconds: 5));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animatePanel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: _toggleAppBarBtn,
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _controller,
              )),
          title: _buildTitle()),
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

  void _animatePanel() {
    if (widget.panelVisible) {
      _controller.fling(velocity: -1);
    }
  }

  void _toggleAppBarBtn() {
    // if (_controller.status == AnimationStatus.dismissed) // at begining
    //   _controller.fling(velocity: 1);
    // else
    //   _controller.fling(velocity: -1);
    if (_controller.status == AnimationStatus.dismissed) // at begining
      _controller.animateTo(1);
    else
      _controller.animateBack(0);
  }

  Widget _buildPanelTitle() => InkWell(
        onTap: () {
          _toggleAppBarBtn();
        },
        child: Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints.expand(height: _panelTitleHeight),
            child: Text("Length", style: TextStyle(fontSize: 25))),
      );

  Widget _buildPanel() => PositionedTransition(
        rect: _anmiationPanel.animate(_controller),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            children: <Widget>[
              _buildPanelTitle(),
              Divider(
                height: _dividerHeight,
              ),
              Expanded(
                child: Converter(),
              )
            ],
          ),
        ),
      );

  AnimatedWidget _buildTitle() {
    return AnimatedBuilder(
      builder: (context, child) => Stack(
            children: <Widget>[
              Opacity(
                opacity: CurvedAnimation(
                        parent: ReverseAnimation(_controller),
                        curve: Interval(0.5, 1))
                    .value,
                child: Text(widget.panelTitle),
              ),
              Opacity(
                opacity: CurvedAnimation(
                        parent: _controller, curve: Interval(0.5, 1))
                    .value,
                child: Text(widget.backdropTitle),
              )
            ],
          ),
      animation: _controller,
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable,
    this.frontTitle,
    this.backTitle,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;
    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      // Here, we do a custom cross fade between backTitle and frontTitle.
      // This makes a smooth animation between the two texts.
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: CurvedAnimation(
              parent: ReverseAnimation(animation),
              curve: Interval(0.5, 1.0),
            ).value,
            child: backTitle,
          ),
          Opacity(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Interval(0.5, 1.0),
            ).value,
            child: frontTitle,
          ),
        ],
      ),
    );
  }
}
