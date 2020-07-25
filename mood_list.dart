import 'package:flutter/material.dart';
import 'package:moodfive/models/mood.dart';
import 'package:provider/provider.dart';
import 'package:moodfive/screens/home/mood_tile.dart';

class MoodList extends StatefulWidget {
  @override
  _MoodListState createState() => _MoodListState();
}

class _MoodListState extends State<MoodList> {
  @override
  Widget build(BuildContext context) {

    final mood= Provider.of<List<Mood>>(context) ?? [];

    mood.forEach((mood){
      print(mood.name);
      print(mood.happy);
      print(mood.strength);

    });
    return ListView.builder(
      itemCount: mood.length,
      itemBuilder: (context, index){
        return MoodTile(
          mood: mood[index]
        );
      },
    );
  }
}
