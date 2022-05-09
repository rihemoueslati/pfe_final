
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forum_republique/Controlles/task_controller.dart';
import 'package:forum_republique/models/task.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';


import '../../constants.dart';
import '../reminder.dart';
import 'button.dart';
import 'input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController= Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime =DateFormat("hh:mm a").format(DateTime.now());
  String _endTime="9:30 PM";
  int _selectedRemind =5 ;
  List<int> remindList=[
    5,
    10,
    15,
    24,
  ];
  String _selectedRepeat ="None" ;
  List<String> repeatList=[
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _selectedColor=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ajouter une tache",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme
                      .of(context)
                      .primaryColor, Theme
                      .of(context)
                      .accentColor,
                  ]
              )
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 16, right: 16,),
            child: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(color: Colors.red,
                      borderRadius: BorderRadius.circular(6),),
                    constraints: BoxConstraints(minWidth: 12, minHeight: 12,),
                    child: Text(
                      '5', style: TextStyle(color: Colors.white, fontSize: 8,),
                      textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Ajouter un évenement",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              MyInputField(title: "Titre", hint: "Entrer votre titre",controller: _titleController,),//titre
              MyInputField(title: "Note", hint: "Entrer votre nom",controller: _noteController,),//note
              MyInputField(
                title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    print('hi there');
                    _getDateFromUser();
                  },
                ),

              ),//date
              Row(
                children: [
                  Expanded(child: MyInputField(
                    title: "Heure de début",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(isStartTime: true);

                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  )),//date debut
                  SizedBox(width: 12,),
                  Expanded(child: MyInputField (
                    title: "Heure de fin",

                    hint: _endTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(isStartTime: false);

                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  )),//datefin
                ],
              ),
              MyInputField(title: "Rappeler", hint: "$_selectedRemind heure d'avance",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),
                  underline: Container(height: 0,),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),

                    );
                }
                ).toList(),
              ),

              ), // rappeler
              MyInputField(title: "Répéter", hint: "$_selectedRepeat",
                  widget: DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),
                    underline: Container(height: 0,),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      }

                      );
                    },
                    items: repeatList.map<DropdownMenuItem<String>>((String? value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value!, style: TextStyle(color: Colors.black87),),

                      );
                    }
                    ).toList(),
                  )
              ),// button
              SizedBox(height: 18,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallete(),
                  MyButton(label: "Crée", onTap: ()=>_validateDate())
                ],
              )
            ],
          ),

        ),
      ),
    );


  }
  _validateDate(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      _addTaskToDb();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReminderPage()));
    }
  }
  _colorPallete(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0,),
        Wrap(
            children: List<Widget>.generate(3, (int index){
              return GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedColor=index;
                    print("$index");
                  });

                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index ==0?primaryColor:index==1?bgColor:secondColor,
                    child: _selectedColor==index?Icon(Icons.done,
                      color: Colors.white,
                      size: 16,
                    ):Container(),

                  ),
                ),
              );
            })
        )


      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2222));
    if (_pickerDate!=null){
      setState(() {
        _selectedDate= _pickerDate;
        print(_selectedDate);
      });
    }else{
      print("c'est nul ou quelque chose ne va pas");
    }
  }
  _getTimeFromUser({required bool isStartTime})async{
    var pickedTime= await _showTimePicker();
    String _formatedtime = pickedTime.format(context);
    if(pickedTime==null){
      print("time canceled");
    }else if (isStartTime==true){
      setState(() {
        _startTime=_formatedtime;
      });

    }else if (isStartTime==false){
      setState(() {
        _endTime=_formatedtime;
      });

    }

  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context:context,
        initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
    ));
  }
  _addTaskToDb() async {
  int value = await _taskController.addTask(
       task:Task(
         note: _noteController.text,
         title: _titleController.text,
         date: DateFormat.yMd().format(_selectedDate),
         startTime: _startTime,
         endTime: _endTime,
         remind: _selectedRemind,
         repeat: _selectedRepeat,
         isCompleted: 0,
       )
   );
  print("My id is "+"$value");
  }

}
