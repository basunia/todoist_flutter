import 'package:flutter/material.dart';
import 'package:todoist_app/model/Project.dart';
import 'package:todoist_app/model/Task.dart';
import 'package:todoist_app/pages/Tasks.dart';
import 'package:todoist_app/provider/auth_provider.dart';
import 'package:todoist_app/widget/progress_bar.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  List<Project>? data = [];
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
          title: Text('Projects'),
        ),
        body: !isLoading
            ? Container(
              padding: EdgeInsets.all(12.0),
                alignment: Alignment.center,
                child: (data != null)
                    ? ListView.builder(
                        itemBuilder: (context, i) {
                          return TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return Tasks(projectId: data![i].id,);
                            }));
                          },
                           child: Text(data![i].name!, style: TextStyle(fontSize: 16.0),));
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
    List<Project>? tasks = await AuthProvider.of(context).getAllProjects();
    setState(() {
      data = tasks;
      isLoading = false;
    });
  }
}
