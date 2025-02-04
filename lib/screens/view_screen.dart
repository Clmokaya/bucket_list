import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class viewItemScreen extends StatefulWidget {
  String title;
  String image;
  int index;
  viewItemScreen(
      {super.key,
      required this.title,
      required this.index,
      required this.image});

  @override
  State<viewItemScreen> createState() => _viewItemScreenState();
}

class _viewItemScreenState extends State<viewItemScreen> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    try {
      Response response = await Dio().delete(
          "https://flutter002-1d47e-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json");
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

  Future<void> markAsComplete() async {
    try {
      Map<String, dynamic> data = {"completed": true};

      Response response = await Dio().patch(
          "https://flutter002-1d47e-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json",
          data: data);
      Navigator.pop(context, "refresh");
    } catch (e) {
      print("error");
    }
  }

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
                        InkWell(onTap: deleteData, child: Text('confirm'))
                      ],
                    );
                  });
            }
            if (value == 2) {
              markAsComplete();
            }
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
