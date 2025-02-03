import 'package:bucket_list/addBucketList.dart';
import 'package:bucket_list/viewItem.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  List<dynamic> bucketListData = [];
  bool isLoading = false;
  bool isError = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await Dio().get(
          "https://flutter002-1d47e-default-rtdb.firebaseio.com/bucketlist.json");

      if (response.data is List) {
        bucketListData = response.data;
      } else {
        bucketListData = [];
      }
      isLoading = false;
      isError = false;

      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget errorWidget({required String errorText}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text(errorText),
          ElevatedButton(onPressed: () {}, child: Text('try again'))
        ],
      ),
    );
  }

  Widget listDataWidget() {
    List<dynamic> filteredList = bucketListData
        .where((element) => !(element?["completed"] ?? false))
        .toList();

    return filteredList.length < 1
        ? Center(child: Text("No data in bucketlist"))
        : ListView.builder(
            itemCount: bucketListData.length,
            itemBuilder: (BuildContext context, int index) {
              return (bucketListData[index] is Map &&
                      (!(bucketListData[index]?["completed"] ?? false)))
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return viewItemScreen(
                              index: index,
                              title: bucketListData[index]['item'] ?? "",
                              image: bucketListData[index]['image'] ?? "",
                            );
                          })).then((value) {
                            if (value == "refresh") {
                              getData();
                            }
                          });
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              bucketListData[index]?['image'] ?? ""),
                        ),
                        title: Text(bucketListData[index]?['item'] ?? ""),
                        trailing: Text(
                            bucketListData[index]?['cost'].toString() ?? ""),
                      ),
                    )
                  : SizedBox();
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return addBucketListScreen(
              newIndex: bucketListData.length,
            );
          })).then((value) {
            if (value == "refresh") {
              getData();
            }
          });
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Bucket List'),
        actions: [
          InkWell(
              onTap: getData,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.refresh),
              ))
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            getData();
          },
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : isError
                  ? errorWidget(errorText: "error connecting...")
                  : listDataWidget()),
    );
  }
}
