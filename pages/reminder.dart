

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:forum_republique/Controlles/task_controller.dart';
import 'package:forum_republique/pages/widgets/add_task_bar.dart';
import 'package:forum_republique/pages/widgets/button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final _taskController = Get.put(TaskController());
  DateTime _selectDate = DateTime.now();
  var notifyHelper ;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    setState(() {
      print("I am here");
    });

  }

  Widget build(BuildContext context) {
    print ("build method called");
    return Scaffold(
      appBar: AppBar( title: Text(" Page des Rappels",
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
      body: Column(
        children: [
          _addTaskBar(),

          Container(
            margin: const EdgeInsets.only(top: 20,left:20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.red,
              selectedTextColor: Colors.white,
              dateTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,

              ),
              dayTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,

              ),
              monthTextStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,

              ),
              onDateChange: (date){
                _selectDate=date;

              },
            ),
          )

        ],
      ),

    );

  }

  // _showTasks(){
  //   return Expanded(
  //     child:Obx((){
  //       return ListView.builder(
  //           itemCount: _taskController.taskList.length,
  //
  //           itemBuilder: (_,context){
  //             print(_taskController.taskList.length);
  //             return Container(
  //               width: 100,
  //               height: 50,
  //               color: Colors.blue,
  //               margin: const EdgeInsets.only(bottom: 10),
  //             );
  //           });
  //     }),
  //   );
  //
  // }
  _addTaskBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now(),),
                  style: TextStyle(fontWeight: FontWeight.bold),

                ),
                Text("Aujourd'hui",
                  style: TextStyle(fontWeight: FontWeight.bold),

                )
              ],
            ),
          ),
          MyButton(label: "+ Ajouter ".toUpperCase(), onTap: (){
            //After successful login we will redirect to profile page. Let's create profile page now
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddTaskPage()));
          },),
        ],
      ),
    );
  }


}



