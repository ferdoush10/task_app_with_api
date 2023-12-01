import 'dart:convert';
//import 'dart:math';
import 'dart:developer';
import 'package:task_mp/ui/controllers/auth_controller.dart';

import 'network_response.dart';
import 'package:http/http.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      log(url);
      log(body.toString());
      final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            'Content-type': 'Application/json',
            'token': AuthController.token.toString()
          });

      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          jsonResponse: jsonDecode(response.body),
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}






// class NetworkCaller {
//   //Sign-in and registration are post method
//   //postRequest Method
//   Future<NetworkResponse> postRequest(String url,
//       {Map<String, dynamic>? body}) async {
//     //Try block
//     try {
//       final Response response =
//           await post(Uri.parse(url), body: jsonEncode(body), headers: {
//         'Content-type': 'Application/json',
//       });

//       // log(response.statusCode.toString());
//       // log(response.body.toString());

//       if (response.statusCode == 200) {
//         return NetworkResponse(
//           isSuccess: true,
//           jsonResponse: jsonDecode(response.body),
//           statusCode: 200,
//           errorMessage: "",
//         );
//       } else {
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           jsonResponse: jsonDecode(response.body),
//         );
//       }
//     }
//     //Catch Block

//     catch (e) {
//       return NetworkResponse(isSuccess: false, errorMessage: e.toString());
//     }
//   }
// }
