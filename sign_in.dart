import 'package:flutter/material.dart';
import 'package:moodfive/services/auth.dart';
import 'package:moodfive/shared/constants.dart';
import 'package:moodfive/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView; //constructor for widget therefore not defined in state object
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey= GlobalKey<FormState>();

  bool loading= false;

  //text field state
  String email= '';
  String password= '';
  String error= '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        elevation: 0.0,
        title: Text('Sign in to Mood Five'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                widget.toggleView(); //referring to stateful widget above
              },
              icon: Icon(Icons.person),
              label: Text('Register'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val)=> val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() {
                    email= val;
                  });

                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val)=> val.length<6 ? 'Enter a password with 6+ characters' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password= val;
                  });

                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color:Colors.pink[300],
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: ()async{
                    if(_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);

                      if (result == null) {
                        setState(() {
                          error = 'Could not sign in with those credentials';
                          loading=false;
                        });
                      }
                    }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                  error,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 14.0,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
