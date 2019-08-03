import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(new MaterialApp(
    title: "Shared Preferences",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = new TextEditingController();
  String _savedData = "";
  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if(sharedPreferences.getString('key_name')!= null && sharedPreferences.getString('key_name').isNotEmpty) {
        _savedData = sharedPreferences.getString('key_name');
      }else{
        _savedData = 'Nothing Saved in SP!';
      }
    });
  }
  _saveData(String message)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('key_name', message);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Shared Preferences'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: new Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: new ListTile(
          title: new TextField(
            controller: _enterDataField,
            decoration: new InputDecoration(labelText: "Write Something"),
          ),
          subtitle: new FlatButton(
            onPressed: () {
            _saveData(_enterDataField.text);
            },
            child: new Column(
              children: <Widget>[
                new Text('Save Data'),
                new Padding(padding: new EdgeInsets.all(15.0)),
                new Text(_savedData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
