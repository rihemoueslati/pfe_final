
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint ;
  final Widget? widget ;
  final TextEditingController? controller;
  const MyInputField({Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(

        children: [
          Column(
          children :[

            Text(
              title,
            style:  TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
              ),

      ],
          ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(
                  child:TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor: Colors.red,
                    controller: controller,
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                          width: 0,
                        )
                      ),
                      enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                           width: 0,
                    ),
                  ) ,
                ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "tous les termes sont obligatoire";
                      }
                      return null;
                    },
    ),
                ),
                widget==null?Container():Container(child: widget),

              ],
            ),

          ),
        ],


      ),
    );
  }
}
