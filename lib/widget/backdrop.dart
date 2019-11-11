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
  bool test = false;

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
            onPressed: _toggleHamburgerBtn,
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

  void _toggleHamburgerBtn() {
    _hidePanelCallback();
    if (_controller.status == AnimationStatus.dismissed) // at begining
      _controller.fling(velocity: 1);
    else
      _controller.fling(velocity: -1);
  }

  void _hidePanelCallback() {
    InheritedHidePanelCallback.of(context).hidePanelCallback();
  }

  Widget _buildPanelTitle() => InkWell(
        onTap: () {
          _hidePanelCallback();
          _toggleHamburgerBtn();
        },
        child: Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints.expand(height: _panelTitleHeight),
            child: Text(widget.panelTitle, style: TextStyle(fontSize: 25))),
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
                child: widget.panel,
              )
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
