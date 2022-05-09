// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Profilemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilModel _$ProfilModelFromJson(Map<String, dynamic> json) => ProfilModel(
      json['firstname'] as String,
      json['lastname'] as String,
      json['location'] as String,
      json['email'] as String,
      json['phone'] as String,
    );

Map<String, dynamic> _$ProfilModelToJson(ProfilModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'location': instance.location,
      'email': instance.email,
      'phone': instance.phone,
    };
