import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}



class _SearchListState extends State<SearchList> {
  @override
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  } //컨트롤러는 dispose에서 지워줘야한다.

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              filterSearchResults(value.trim());
            },
            controller: editingController,
            decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: ScrollController(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${items[index]}'),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class SearchWorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SearchList(),
    );
  }
}
