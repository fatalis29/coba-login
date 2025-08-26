import 'dart:convert';
import 'dart:developer';

import 'package:cryptography/cryptography.dart';
import 'package:dbank/auth/auth.dart';
import 'package:dbank/auth/moffas.dart';
import 'package:dbank/models/auth_response.dart';
import 'package:dio/dio.dart';

class DioSingleton {
  static final DioSingleton _instance = DioSingleton._internal();
  factory DioSingleton() => _instance;

  int a = 0; // lets check this

  DioSingleton._internal();
  
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: 'https://yuriva.com/dmoney',
      headers: {
        'Bdi-Signature': 'c283f0f39f3d7a5155a3cce0919ab1739be028e1cd6a75a004e002005f5b015e',
        'Bdi-Timestamp': 'timestamp2024-02-13T07:55:39.053Z', 
        'Bdi-Key': 'a6961472-a2da-4d91-a2bb-8ff009844eee',
        'Url': '/dmoney/auth'
      },
    )
  );
  // ..interceptors.add(
  //   AuthInterceptor()
  // );

  // / Requests 
  Future<Response> postLoginInfo(String username, String password) async {
    // auth
    String clientFirstMessage = getClientFirstMessage('0000552027', 'e45RyNKtIcbk3RbI');
    var response = await _client.post(
      '/auth',
      data: {
        "data":"$clientFirstMessage", // TODO: create r function
        "AuthType":"login"
      },
    );
    log("authResponseHeader ${response.headers}");
    log("authResponseData ${response.data}");
    log("authResponseExtra ${response.extra}");
    // log("authResponseOptions ${response.requestOptions.data}\n${response.requestOptions}");
    // log("data: ${response.data.toString()}");

    // fin
    try {
      var responseData = response.data;
      var stringResponse = responseData['response'];
      var expiryResponse = responseData['expiry'];
      var jsonResponse = stringResponse?.split(',').map((val) => val.substring(2));
      AuthResponse authResponse = AuthResponse(r: jsonResponse.elementAt(0), s: jsonResponse.elementAt(1), i: jsonResponse.elementAt(2), expiry: expiryResponse);
      
      // String data2 = await getDataFin(clientFirstMessage, authResponse);
      String dataFin = "c=${c(clientFirstMessage)},r=${authResponse.r},p=${await p('0000552027', '123456', 'e45RyNKtIcbk3RbI', authResponse)}";
      String sequance = getSequence();
      String payload = await getPayload(authResponse.r);
      var saltedPassword = await getSaltedPassword('123456', authResponse.s, int.parse(authResponse.i));
      
      SecretKey aesk = await getAesk(Base64Codec().encode(saltedPassword.bytes), authResponse.r);
      String hash = await getHash(payload, sequance, aesk);

      log("dataFin:$dataFin");
      var response2 = await _client.post(
        '/fin',
        data: {
          "data": dataFin,
          "payload": payload,
          "seq": seq,
          "hash": hash
        }
      );
      log('fin:${response2.headers.toString()}');
    } on Exception catch (e) {
      log('ERROR: ${e}');
    }
    return response;
  }

  // Future<Response> postLoginInfo() async {
  //   // auth
  //   String clientFirstMessage =  "n,,n=user";
  //   // var response = await _client.post(
  //   //   '/auth',
  //   //   data: {
  //   //     "data":"$clientFirstMessage,r=e45RyNKtIcbk3RbI", // TODO: create r function
  //   //     "AuthType":"login"
  //   //   },
  //   // );

  //   // fin
  //   var stringResponse = "r=fyko+d2lbbFgONRv9qkxdawL3rfcNHYJY1ZVvWVs7j,s=QSXCR+Q6sek8bf92,i=4096";
  //   var expiryResponse = 170000;
  //   var jsonResponse = stringResponse.split(',').map((val) => val.substring(2));
  //   AuthResponse authResponse = AuthResponse(r: jsonResponse.elementAt(0), s: jsonResponse.elementAt(1), i: jsonResponse.elementAt(2), expiry: expiryResponse);
  //   String data2 = "c=${c(clientFirstMessage)},r=${authResponse.r},p=${await p('0000552027', '123456', authResponse)}";
  //   log("data2:$data2");
  //   var response2 = await _client.post(
  //     '/auth',
  //     data: {
  //       "data": data2
  //     }
  //   );
  //   log('fin:${response2.headers.toString()}');
  //   return response2;
  // }

}

