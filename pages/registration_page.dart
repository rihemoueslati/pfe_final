import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum_republique/classes/user.dart';

import 'package:forum_republique/common/theme_helper.dart';
import 'package:forum_republique/pages/widgets/header_widget.dart';
import 'package:forum_republique/utils/server_config.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'login_page.dart';
import 'profile_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
  }

  _register() async {}

  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState() => this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  bool checkedValue = false;
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
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
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: image != null
                                    ? Image.file(
                                        image!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        Icons.person,
                                        color: Colors.grey.shade300,
                                        size: 80.0,
                                      ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                  child: IconButton(
                                    onPressed: () =>
                                        pickImage(ImageSource.gallery),
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Colors.grey.shade700,
                                      size: 25.0,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                              controller: firstNameController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'First Name', 'Enter your first name'),
                              validator: (val) {
                                if (val!.isEmpty)
                                  return "Please enter your name";
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
                                  'Last Name', 'Enter your last name'),
                              validator: (val) {
                                if (val!.isEmpty)
                                  return "Please enter your last  name";
                              }),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail addresse", "Entrer votre email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Entrer un email valide";
                              } else if (val.isEmpty)
                                return "Please enter your email adresse";
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
                                "Entrer votre numéro de télephone"),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if (!(val!.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val))  {
                                return "Enter a valid phone number";
                              } else if (val.isEmpty) {
                                return "Please enter your mobile phone";
                              }else if (val.length < 8)
                              {
                                return "Enter a valid phone number";
                              }
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
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(
                                      "J'accepte tous les termes et conditions.",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'Vous devez accepter les termes et conditions';
                            } else {
                              return null;
                            }
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
                                "Registrer".toUpperCase(),
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
                        SizedBox(height: 30.0),
                        Text(
                          "Ou créez un compte en utilisant les médias sociaux",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus,
                                size: 35,
                                color: HexColor("#EC2D2F"),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Google Plus",
                                          "You tap on GooglePlus social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: HexColor("#40ABF0")),
                                  color: HexColor("#40ABF0"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.twitter,
                                  size: 23,
                                  color: HexColor("#FFFFFF"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Twitter",
                                          "You tap on Twitter social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                size: 35,
                                color: HexColor("#3E529C"),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Facebook",
                                          "You tap on Facebook social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
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
