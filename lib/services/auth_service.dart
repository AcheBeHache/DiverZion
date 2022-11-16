import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBd83bWeO8RD0eQGu1rWL8cISGqxm7xKiA';

  final storage = const FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      await storage.write(key: 'usremail', value: decodedResp['email']);
      // decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  //Getters del token de forma estática
  static Future<String?> getEmail() async {
    const storage = FlutterSecureStorage();
    final email = await storage.read(key: 'usremail');
    return email;
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      // decodedResp['idToken'];
      /*print("--------------");
      print(decodedResp['email']);*/
      await storage.write(key: 'token', value: decodedResp['idToken']);
      await storage.write(key: 'usremail', value: decodedResp['email']);
      return null;
    } else {
      //print(decodedResp);
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    //agregué los siguientes 2 deletes
    await storage.delete(key: 'usremail');
    await storage.delete(key: 'idBolsa');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> readEmail() async {
    //print(storage.read(key: 'usremail'));
    return await storage.read(key: 'usremail') ?? '';
    /*String? value = await storage.read(key: 'usremail') ?? '';
    return value;*/
    /*String value = await storage.read(key: 'usremail') ?? '';
    return value; */
    //print('---------');

    //return decodedResp['token']['email'];
  }
}
