import 'package:flutter/material.dart';
import 'package:todoist_app/provider/auth_provider.dart';

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
      body: Center(
        child: Column(
          children: [
            Text(
              'Hello todoister',
              textScaleFactor: 1.5,
            ),
            TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text('Login with todoist'),
                onPressed: () =>
                    AuthProvider.of(context).oAuth2Login((accessToken) {
                      print('Access token $accessToken');
                    })),
          ],
        ),
      ),
    );
  }
}
