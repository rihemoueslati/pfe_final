import 'package:flutter/material.dart';
import 'package:forum_republique/classes/user.dart';
import 'package:forum_republique/utils/server_config.dart';

import 'list_adherent.dart';
import 'package:http/http.dart' as http;
class MyDetail extends StatefulWidget {
  User user;
  MyDetail(this.user);
  @override
  _MyDetailState createState() => _MyDetailState(this.user);
}

class _MyDetailState extends State<MyDetail> {
  User user;
  _MyDetailState(this.user);
  void edit(){
    Navigator.push(context,  MaterialPageRoute(builder: (context)=>Home(0,user.id)));
  }
  void delete() async{
    await http.delete(Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/del/${user.id}"));
    Navigator.push(context,  MaterialPageRoute(builder: (context)=>Home(1,0)));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title:Text(user.firstName)),
        body:Container(
          child:Padding(padding: EdgeInsets.all(19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.all(19),
              child:Text("Id: "+user.id.toString(),style: TextStyle(
                fontSize: 20
              ),),),
              Padding(padding: EdgeInsets.all(19),
              child:Text("Name: "+user.firstName,style: TextStyle(
                fontSize: 20
              ),),),
            /*  Padding(padding: EdgeInsets.all(19),
              child:Text("Email: "+user.email,style: TextStyle(
                fontSize: 20
              ),),),*/
              Row(
                children: [
                  MaterialButton(onPressed: edit,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Edit"),
                  ),
                  Spacer(),
                  MaterialButton(onPressed: delete,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text("Delete"),
                  ),
                ],
              )
            ],
          ),
          )
        )
      ),
    );
  }
}
