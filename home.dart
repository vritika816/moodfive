import 'package:flutter/material.dart';
import 'package:moodfive/models/mood.dart';
import 'package:moodfive/screens/home/settings_form.dart';
import 'package:moodfive/services/auth.dart';
import 'package:moodfive/services/database.dart';
import 'package:provider/provider.dart';
import 'package:moodfive/screens/home/mood_list.dart';


class Home extends StatelessWidget {

  final AuthService _auth= AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Mood>>.value(
      value: DatabaseService().mood,
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Text('Mood Five'),
          backgroundColor: Colors.pink[200],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
            },
                icon: Icon(Icons.person),
                label: Text('logout'),
            ),
            FlatButton.icon(
                onPressed: ()=> _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('Settings'),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
            child: MoodList()
        ),
      ),
    );
  }
}
