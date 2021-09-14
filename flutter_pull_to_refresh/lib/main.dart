import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pull To Refresh',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _demoData = [];
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    // TODO: implement initState
    _demoData = [
      "Flutter",
      "React Native",
      "Cordova/ PhoneGap",
      "Native Script"
    ];
    _scaffoldKey = GlobalKey();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: ListView.builder(
          itemBuilder: (ctx, idx) {
            // List Item
            return Card(
              child: ListTile(
                title: Text(_demoData[idx]),
              ),
            );
          },

          // Length of the list
          itemCount: _demoData.length,

          // To make listView scrollable
          // even if there is only a single item.
          physics: const AlwaysScrollableScrollPhysics(),
        ),
        // Function that will be called when
        // user pulls the ListView downward
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
                () {
              /// adding elements in list after [1 seconds] delay
              /// to mimic network call
              ///
              /// Remember: [setState] is necessary so that
              /// build method will run again otherwise
              /// list will not show all elements
              setState(() {
                _demoData.addAll(["Ionic", "Xamarin"]);
              });

              // showing snackbar
              _scaffoldKey.currentState!.showSnackBar(
                SnackBar(
                  content: const Text('Page Refreshed'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
