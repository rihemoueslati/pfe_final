

import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forum_republique/classes/Association.dart';
import 'package:forum_republique/classes/user.dart';
import 'package:forum_republique/pages/listuserbylocal.dart';
import 'package:forum_republique/utils/server_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;



class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var users = <User>[];
  var user;

  Future<List<User>> getUserBylocal() async {
   var data = await http.get(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/GetAllU"),headers: {"Content-Type": "application/json","Accept": "application/json"});
    var jsonData = json.decode(data.body);
    List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
    Iterable list = json.decode(data.body);
    if(data.statusCode==201 ||data.statusCode==200){
      users = list.map((model) => User.fromJson(model)).toList();
    }else {
      print('error !');
    }
    return users;
  }

  static const _initialCameraPosition = CameraPosition(target: LatLng(36.806389, 10.181667),
    zoom: 11.5,
  );
 late GoogleMapController _googleMapController;

  var myMarkers = HashSet<Marker>();//collection
    late BitmapDescriptor customMarker;
   // getCustomMarker () async{
   //   customMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/logo.png');
   //   var data = await http.get(
   //       Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/GetAllU"),headers: {"Content-Type": "application/json","Accept": "application/json"});
   //   var jsonData = json.decode(data.body);
   //   List<Association> markerFromJson(String str) => List<Association>.from(json.decode(str).map((x) => Association.fromJson(x)));
   //   Iterable list = json.decode(data.body);
   //   if(data.statusCode==201 ||data.statusCode==200){
   //     Associations = list.map((model) => Association.fromJson(model)).toList();
   //   }else {
   //     print('error !');
   //   }
   //   return Associations;
   //
   // }

   @override
   void initState(){
     super.initState();
     // getCustomMarker();
     getUserBylocal();

   }

 @override
 void dispose(){
   _googleMapController.dispose();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Map ",
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
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition ,
        onMapCreated: (GoogleMapController googleMapController){
          setState(() {
            myMarkers.add(
              Marker(
                  markerId: MarkerId('1'),
            position: LatLng(36.806389, 10.181667),
                onTap: (){
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,  MaterialPageRoute(builder: (context) =>  ListUserByLocal()));
                      },

                    );
                }




            ),

            );
          });
        },
        markers: myMarkers,


      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor:  Colors.black87,
          onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition)),
          child: const Icon(Icons.center_focus_strong),
        ),




    );
  }


}



