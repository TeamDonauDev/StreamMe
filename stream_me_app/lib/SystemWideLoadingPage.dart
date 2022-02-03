import 'package:flutter/material.dart';

class SystemWideLoadingPage extends StatelessWidget{
  final String title;
  const SystemWideLoadingPage({Key? key, required this.title} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Text(title),
    );
  }

}