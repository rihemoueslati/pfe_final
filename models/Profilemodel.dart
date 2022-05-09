

import 'package:json_annotation/json_annotation.dart';
part 'Profilemodel.g.dart';


@JsonSerializable()
class ProfilModel {
  String firstname;
  String lastname;
  String location;
  String email;
  String phone;
  ProfilModel(
  this.firstname,this.lastname,this.location,this.email,this.phone
  );
  factory ProfilModel.fromJson(Map<String,dynamic>json)=> _$ProfilModelFromJson(json);
  Map<String,dynamic> toJson()=> _$ProfilModelToJson(this) ;

}
