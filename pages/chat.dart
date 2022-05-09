
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_republique/classes/message.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';


class Messagerie extends StatefulWidget {
  const Messagerie({Key? key}) : super(key: key);

  @override
  _MessagerieState createState() => _MessagerieState();
}

class _MessagerieState extends State<Messagerie> {
  List<Message> messages =[
    Message(
        text:'YES sure!',
        date: DateTime.now().subtract(Duration(days: 3,minutes: 1)),
        isSentByMe: false,
    ),


  ].reversed.toList();
  @override
  Widget build(BuildContext context) {
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
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: GroupedListView<Message, DateTime>(
            padding: const EdgeInsets.all(8),
            reverse: true,
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: messages,
            groupBy: (message)=> DateTime(
              message.date.year,
              message.date.month,
              message.date.day,
            ),
            groupHeaderBuilder: (Message message)=> SizedBox(
              height: 40,
              child: Center(
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      DateFormat.yMMMd().format(message.date),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            itemBuilder: (context, Message message)=>Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,

              child : Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(message.text),
                ),
              ),
            ),
          )),
          Container(
            color: Colors.grey.shade300,
            child: TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'Type your message here...',
              ),

              onSubmitted: (text){
                final message =Message(
                    text: text,
                    date: DateTime.now(),
                    isSentByMe: true);
                setState(() => messages.add(message));
              },

            ),
          ),
        ],
      ),
    );

  }
}


