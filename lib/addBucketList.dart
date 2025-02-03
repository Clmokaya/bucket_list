import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class addBucketListScreen extends StatefulWidget {
  int newIndex;
  addBucketListScreen({super.key, required this.newIndex});

  @override
  State<addBucketListScreen> createState() => _addBucketListScreenState();
}

class _addBucketListScreenState extends State<addBucketListScreen> {
  TextEditingController itemText = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController imageURLText = TextEditingController();

  Future<void> addData() async {
    try {
      Map<String, dynamic> data = {
        "item": itemText.text,
        "cost": cost.text,
        "image": imageURLText.text,
        "completed": false
      };

      Response response = await Dio().patch(
          "https://flutter002-1d47e-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json",
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
          title: Text('Add Bucket List'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: itemText,
                decoration: InputDecoration(label: Text('Item')),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: cost,
                decoration: InputDecoration(label: Text('Estimated cost')),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: imageURLText,
                decoration: InputDecoration(label: Text('Image URL')),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: addData, child: Text('Add Item'))),
                ],
              )
            ],
          ),
        ));
  }
}
