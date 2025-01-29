import 'package:flutter/material.dart';

class addBucketListScreen extends StatefulWidget {
  const addBucketListScreen({super.key});

  @override
  State<addBucketListScreen> createState() => _addBucketListScreenState();
}

class _addBucketListScreenState extends State<addBucketListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bucket List'),
      ),
    );
  }
}
