import 'package:flutter/material.dart';
import 'package:todoist_app/provider/auth_provider.dart';

Widget circularProgress() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget loginButton(BuildContext context, Function onLoginCallback){
  final accessToken = AuthProvider.of(context).accessToken;
  return (accessToken!= null && (accessToken as String).isNotEmpty)? 
   TextButton(
      onPressed: (){
        Scaffold.of(context).openDrawer();
    }, child: Text('Open navigation drawer'))
  
  :TextButton(
    onPressed: (){
      AuthProvider.of(context).oAuth2Login((accessToken){
        onLoginCallback(accessToken);
      });
  }, child: Text('Log in with todoist'));
}
