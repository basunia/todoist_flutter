import 'package:flutter/material.dart';
import 'package:todoist_app/model/Project.dart';
import 'package:todoist_app/model/Task.dart';
import 'package:todoist_app/provider/auth_provider.dart';
import 'package:todoist_app/widget/progress_bar.dart';

class Tasks extends StatefulWidget {

  Tasks({this.projectId});
  final int? projectId;
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<Task>? data = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tasks'),
        ),
        body: !isLoading
            ? Container(
              padding: EdgeInsets.all(12.0),
                alignment: Alignment.center,
                child: (data != null)
                    ? ListView.builder(
                        itemBuilder: (context, i) {
                          return Text(data![i].content!, style: TextStyle(fontSize: 16.0),);
                        },
                        itemCount: data?.length,
                      )
                    : Text("No tasks"),
              )
            : circularProgress(),
      ),
    );
  }

  loadTasks() async {
    setState(() {
      isLoading = true;
    });
    List<Task>? tasks = await AuthProvider.of(context).getAllTasks(widget.projectId!);
    setState(() {
      data = tasks;
      isLoading = false;
    });
  }
}
