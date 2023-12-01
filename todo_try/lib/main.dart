import 'package:flutter/material.dart';
import 'package:todo_try/models.dart';
import './api_methods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 16, 51, 207)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TaskLists'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<TaskList>> futureTasklist;

  @override
  void initState() {
    super.initState();
    futureTasklist = fetchTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: TasklistScreen(futureTasklist: futureTasklist),
    );
  }
}

class TasklistScreen extends StatelessWidget {
  const TasklistScreen({
    super.key,
    required this.futureTasklist,
  });

  final Future<List<TaskList>> futureTasklist;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<TaskList>>(
        future: futureTasklist,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return buildPosts(posts);
          } else {
            return const Text("No data available");
          }
        },
      ),
    );
  }
}

Widget buildPosts(List<TaskList> posts) {
  late Future<List<Task>> futureTask;

  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      final post = posts[index];
      Size screenSize = MediaQuery.of(context).size;
      return GestureDetector(
        onTap: () => {
          showDialog(
            context: context,
            barrierColor: Colors.white,
            builder: (BuildContext context) {
              futureTask = fetchTask(post.id!);
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Column(
                          children: [
                            Text(
                              "Tasks in ${post.name!}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(post.desc!),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (screenSize.height - 50),
                    child: FutureBuilder<List<Task>>(
                      future: futureTask,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          final posts = snapshot.data!;
                          return buildTasks(posts);
                        } else {
                          return const Text("No data available");
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          )
        },
        child: Container(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          height: 70,
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                post.name!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
              Expanded(child: Text(post.desc!)),
            ],
          ),
        ),
      );
    },
  );
}

Widget buildTasks(List<Task> posts) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      final post = posts[index];
      return GestureDetector(
        onTap: () => {},
        child: Container(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          height: 70,
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                post.title!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
              const SizedBox(width: 10),
              Expanded(child: Text(post.desc!)),
            ],
          ),
        ),
      );
    },
  );
}