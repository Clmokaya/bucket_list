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
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == 1) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Are you sure to delete?'),
                      actions: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text('cancel')),
                        Text('confirm')
                      ],
                    );
                  });
            }
            print(value);
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: 1, child: Text('delete')),
              PopupMenuItem(value: 2, child: Text('Mark as complete'))
            ];
          })
        ],
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
