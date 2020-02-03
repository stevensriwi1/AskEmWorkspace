// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userAuth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuth _$UserFromJson(Map<String, dynamic> json) {
  return UserAuth(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserToJson(UserAuth instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
