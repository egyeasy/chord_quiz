import 'package:flutter/material.dart';

class DisplayView extends StatefulWidget {
  const DisplayView({Key? key}) : super(key: key);

  @override
  State<DisplayView> createState() => _DisplayViewState();
}

class _DisplayViewState extends State<DisplayView> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text("dfef"),
    );
  }
}