import 'package:flutter/material.dart';
import 'package:forum_republique/classes/user.dart';
import 'package:forum_republique/common/theme_helper.dart';
import 'package:forum_republique/pages/widgets/header_widget.dart';
import 'package:forum_republique/utils/server_config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'list_adherent.dart';
import 'dart:convert';

import 'login_page.dart';
class MyForm extends StatefulWidget {
  int id;
  MyForm(this.id);
  @override
  _MyFormState createState() => _MyFormState(this.id);
}

class _MyFormState extends State<MyForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int id;
  _MyFormState(this.id);
  //User user = User(id: 0,firstName: 'Sting',lastName: '',email: '');
  Future save() async {
/*    final msg = jsonEncode(<String, String>{
      "email": "eeeeeeeeee",
      "firstName": "string",
      "lastName": "string",
      "password": "string",
      "resetPasswordToken": "string",
      "telephone": "string"
    });
    Map<String, String> headers = {
      "Context-Type": "application/json",
      "Accept": "application/json",
    };*/
    var res = await  http.post(
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/ajout"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": emailController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "password": passwordController.text,
        "resetPasswordToken": passwordController.text,
        "telephone": phoneNumberController.text,
      }),
    );
    /*   var res = await http.post(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/ajout"),
        headers: headers,
        body: msg);*/
    if(res.statusCode==201 ||res.statusCode==200){
      Navigator.push(
          context,  MaterialPageRoute(builder: (context) => const LoginPage()));
    }else {
      print('error !');
    }
    print("res.bodyres.body ${res.body}");
    print("statusCodestatusCodestatusCode ${res.statusCode}");
/*  */
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(this.id != 0){
      getOne();
    }
  }
  void getOne() async{
    var data = await http.get(Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/GetAllU/${this.id}"));
    var u = json.decode(data.body);
    setState(() {
      List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
print("userFromJsonuserFromJson  $userFromJson");
     // user = User(u['id'], u['name'], u['email'], u['password']);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [

            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                              controller: firstNameController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'First Name', 'Enter first name'),
                              validator: (val) {
                                if (val!.isEmpty)
                                  return "Please enter name";
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                              controller: lastNameController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Last Name', 'Enter the last name'),
                              validator: (val) {
                                if (val!.isEmpty)
                                  return "Please enter last  name";
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail addresse", "Entrer un email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Entrer un email valide";
                              } else if (val.isEmpty)
                                return "Please enter email adresse";
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: phoneNumberController,
                            decoration: ThemeHelper().textInputDecoration(
                                "Numéro de télephone",
                                "Entrer un numéro de télephone"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Enter a valid phone number";
                              } else if (val.isEmpty)
                                return "Please entermobile phone";
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Mot de passe", "Entrer votre mot de passe"),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Entrer votre mot de passe";
                                } else if (val.length < 8) {
                                  return "Entrer un mot de passe valide";
                                }
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[

                              ],
                            );
                          },

                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                          ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Enregistrer".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                save();
                              }
                            },
                          ),
                        ),


                          ],
                        ),

                    ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
