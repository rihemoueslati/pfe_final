
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forum_republique/classes/callapi.dart';
import 'package:forum_republique/classes/user.dart';
import 'package:forum_republique/common/theme_helper.dart';
import 'package:forum_republique/utils/server_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';
import 'package:http/http.dart' as http ;

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late String errorText;
  bool validate=false;
  bool circular=false;
  double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  Future login() async {
    var res = await  http.post(
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/auth/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": emailController.text,
        "password": passwordController.text,

      }),
    );
    /*   var res = await http.post(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/ajout"),
        headers: headers,
        body: msg);*/
    if(res.statusCode==201 ||res.statusCode==200){
      Navigator.push(
          context,  MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    print("res.bodyres.body ${res.body}");
    print("statusCodestatusCodestatusCode ${res.statusCode}");
/*  */
  }
  Future verif() async {
    var res = await  http.post(
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/auth/verif"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": emailController.text,
      }),
    );
    if(res.statusCode==201 ||res.statusCode==200){
      Navigator.push(
          context,  MaterialPageRoute(builder: (context) =>  ProfilePage()));
    }else {
      print('error !');
    }
    print("res.bodyres.body ${res.body}");
    print("statusCodestatusCodestatusCode ${res.statusCode}");
/*  */
  }
  _showMsg(msg) { //
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF363f93),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  _login() async {
    var data = {
      'email' : emailController.text,
      'password' : passwordController.text,
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    print(body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => ProfilePage()));
    }else{
      _showMsg(body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          key: _formKey,
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    Image(
                       image: NetworkImage('https://scontent.ftun1-2.fna.fbcdn.net/v/t1.6435-9/117648424_637219530239329_370547406072171631_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=7Wo4-b6DoMoAX9Ly9fa&_nc_ht=scontent.ftun1-2.fna&oh=00_AT9nL9CvIDVBTxfA2XkNnFcoo6_agLKVq04JVUfs7QqEug&oe=627FCCE2'),
                      height: 100,
                      width: 100,
                    ),
                    Text(
                        'FORUM DE LA REPUBLIQUE',
                      style: TextStyle(
                          color: Colors.red,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    Text(
                      'connectez-vous à votre compte',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(

                        child: Column(
                          children: [
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration('Nom d\'utilisateur', 'Entrez votre nom d\'utilisateur'
                                ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Entrer votre nom !";
                                    }else {
                                      verif();
                                    }
                                  }



                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextFormField(
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration('Mot de passe', 'Entrez votre Mot de passe'),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Entrer votre mot de passe";
                                    } else if (val.length<8) {
                                      return "Entrer un mot de passe valide";
                                    }
                                  }
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                },
                                child: Text( "Mot de passe oublié?", style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('identifier'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: (){
                                  // if (_formKey.currentState!.validate()) {
                                  //   verif();
                                  // }else{
                                  //   _login();
                                  // }

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));




                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "vous n'avez pas de compte? "),
                                    TextSpan(
                                      text: 'Créer',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
}
