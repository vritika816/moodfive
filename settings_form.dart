import 'package:flutter/material.dart';
import 'package:moodfive/models/user.dart';
import 'package:moodfive/services/database.dart';
import 'package:moodfive/shared/constants.dart';
import 'package:moodfive/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey= GlobalKey<FormState>();
  final List<String> happy= ['happy', 'sad', 'confused', 'okay', 'nervous', 'angry', 'fed up', 'excited', 'hungry', 'PERIODS!!'];

  String _currentName;
  String _currentHappy;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData= snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                Text(
                  'Update your mood',
                  style: TextStyle(fontSize: 18.0),
                ),

                SizedBox(height: 20.0),

                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val)=> val.isEmpty? 'Please enter a name': null,
                  onChanged: (val)=> setState(()=> _currentName= val),
                ),

                SizedBox(height: 20.0),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentHappy ?? 'happy',
                  items: happy.map((happy){
                    return DropdownMenuItem(
                      value: happy,
                      child: Text('$happy'),
                    );
                  }).toList(),
                  onChanged: (val)=> setState(()=> _currentHappy= val),
                ),

                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.pink[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.blue[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val)=> setState(()=> _currentStrength = val.round()),
                ),
                //slider
                RaisedButton(
                  color: Colors.pink[300],
                  child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentHappy?? userData.happy,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );

        } else {

          return Loading();

        }

      }
    );
  }
}
