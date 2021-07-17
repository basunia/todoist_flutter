import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:todoist_app/model/Project.dart';
import 'package:todoist_app/pages/Tasks.dart';
import 'package:todoist_app/provider/auth_provider.dart';
import 'package:todoist_app/widget/progress_bar.dart';

import 'Projects.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todoist flutter'),
      ),
      drawer: Drawer(child: Projects()),
      body: Center(
        child: Column(
          children: [
            Text(
              'Hello todoister',
              textScaleFactor: 1.5,
            ),
            loginButton(context, (accessToken){
              toast('Login successfull');
            })
            // TextButton(
            //     style: ButtonStyle(
            //       foregroundColor:
            //           MaterialStateProperty.all<Color>(Colors.blue),
            //     ),
            //     child: Text('Login with todoist'),
            //     onPressed: () =>
            //         AuthProvider.of(context).oAuth2Login((accessToken) {
            //           print('Access token $accessToken');
            //           if (accessToken != null) {
            //             // Navigator.of(context)
            //             //     .push(MaterialPageRoute(builder: (context) {
            //             //   return Projects();
            //             // }));
            //             toast('Login successfull');
            //           }
            //         })),
          ],
        ),
      ),
    );
  }
}
