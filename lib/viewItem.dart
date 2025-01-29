import 'package:flutter/material.dart';

class viewItemScreen extends StatefulWidget {
  String title;
  String image;
  viewItemScreen({super.key, required this.title, required this.image});

  @override
  State<viewItemScreen> createState() => _viewItemScreenState();
}

class _viewItemScreenState extends State<viewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(widget.image))),
          ),
        ],
      ),
    );
  }
}
