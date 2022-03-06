import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const myChannel = MethodChannel("me.niamulhasan/myChannelName");

  String data = "Waitting...";

  Future getData() async {
    try {
      final String result = await myChannel.invokeMethod('getDataFromAndroid');
      data = "Data is $result";
    } on Exception catch (e) {
      data = "Failed to get data ${e}";
    }

    setState(() {
      data = "$data";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(data),
            ElevatedButton(onPressed: getData, child: Text("Get"))
          ],
        ),
      ),
    );
  }
}
