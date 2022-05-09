

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forum_republique/pages/registration_page.dart';
import 'package:forum_republique/pages/reminder.dart';
import 'package:forum_republique/pages/splash_screen.dart';

import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'home_screen.dart';
import 'login_page.dart';
import 'map.dart';

class Body extends StatelessWidget {
  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Page de Profil",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
              )
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( top: 16, right: 16,),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                    constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
                    child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text("tableau de bord",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                title: Text('Premiére Page', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Premiére Page")));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Page de Connexion', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                },
              ),
              ListTile(
                leading: Icon(Icons.timer,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Page des Rappels', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderPage()),);
                },
              ),
              ListTile(
                leading: Icon(Icons.map,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Maps', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()),);
                },
              ),
              ListTile(
                leading: Icon(Icons.dashboard,size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Menu', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Page de Registration ',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Page de Mot de Passe oublier',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Page de Verification ',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()), );
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Déconnecter',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children:[
          SizedBox(height: 19,width: 19,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                children:[
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()),),
                    icon: Icon(
                      Icons.map,
                      color: Colors.red.shade700,
                      size: 70.0,
                    ),
                  ),
                  SizedBox(height: 19,),
                  Text(
                    'Email', style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),
                ]
            ),
          ),
          SizedBox(height: 19,width: 19,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                children:[
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderPage()),),
                    icon: Icon(
                      Icons.timer,
                      color: Colors.red.shade700,
                      size: 70.0,
                    ),
                  ),
                  SizedBox(height: 19,),
                  Text(
                    'Rappel', style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),
                ]
            ),
          ),
          SizedBox(height: 19,width: 19,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
                height: 150, width: 150,
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      offset: Offset(5, 5),
                      color: Colors.red.withOpacity(0.1),
                    ),
                    BoxShadow(
                      blurRadius: 3,
                      offset: Offset(-5, -5),
                      color: Colors.red.withOpacity(0.1),
                    )
                  ],
                ),
                child: Column(
                  children:[
                    IconButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()),),
                      icon: Icon(
                        Icons.map,
                        color: Colors.red.shade700,
                        size: 70.0,
                      ),
                    ),
                 SizedBox(height: 19,),
                 Text(
                  'Map', style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
                 ]
                ),
            ),
          ),//Map

       ]
      ),
    );
  }
}
