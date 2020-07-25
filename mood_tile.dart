import 'package:flutter/material.dart';
import 'package:moodfive/models/mood.dart';

class MoodTile extends StatelessWidget {

  final Mood mood;
  MoodTile({this.mood});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.pink[mood.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(mood.name),
          subtitle: Text('is feeling ${mood.happy}'),
        ),
      ),
    );
  }
}
