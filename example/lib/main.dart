import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_file_storage/local_file_storage.dart' as Storage;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Storage Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({Key key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final String myFileName = 'myFile';

  String displayString = 'Watch me change!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Text(
                    '$displayString',
                    style: Theme.of(context).textTheme.headline4,
                  ))),
              RaisedButton(
                  onPressed: () {
                    Storage.writeFile(myFileName, "We Did It!");
                  },
                  padding: EdgeInsets.all(20),
                  color: Theme.of(context).primaryColor,
                  child: Text('Write To File',
                      style: Theme.of(context).textTheme.headline4)),
              SizedBox(height: 16),
              RaisedButton(
                  onPressed: () async {
                    String fromFile = await Storage.readFile(myFileName);
                    if (fromFile != null) {
                      setState(() {
                        displayString = fromFile;
                      });
                    } else {
                      setState(() {
                        displayString = 'No File To Read!';
                      });
                    }
                  },
                  padding: EdgeInsets.all(20),
                  color: Theme.of(context).primaryColor,
                  child: Text('Read From File',
                      style: Theme.of(context).textTheme.headline4)),
              SizedBox(height: 16),
              RaisedButton(
                  onPressed: () async {
                    File fromFile = await Storage.deleteFile(myFileName);
                    if (fromFile != null) {
                      setState(() {
                        displayString = 'File Deleted!';
                      });
                    } else {
                      setState(() {
                        displayString = 'No File To Delete!';
                      });
                    }
                  },
                  padding: EdgeInsets.all(20),
                  color: Theme.of(context).primaryColor,
                  child: Text('Delete',
                      style: Theme.of(context).textTheme.headline4))
            ],
          ),
        ));
  }
}
