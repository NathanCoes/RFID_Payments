import 'package:flutter/material.dart';

class LayoutWidget extends StatefulWidget {

  const LayoutWidget({
    super.key, 
    required this.layoutWidget,
    required this.titleLayout,
  });

  final Widget layoutWidget;
  final String titleLayout;

  @override
  State<LayoutWidget> createState() {
    return _LayoutWidgetState();
  }
}

class _LayoutWidgetState extends State<LayoutWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleLayout),
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: widget.layoutWidget,
      ),
    );
  }
}