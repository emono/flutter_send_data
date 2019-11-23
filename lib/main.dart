import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Todo {
  final String title;
  final String context;
  final bool isUrl;
  Todo({this.title, this.context, this.isUrl});
}

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: TodosScreen(
      todos: [
          Todo(title: "no context"),
          Todo(title: "text(isurl is null)",context: "hoge"),
          Todo(title: "text(isUrl is false)",context: "hoge", isUrl: false),
          Todo(title: "url", context: "https://www.youtube.com/watch?v=McaEBf-tAlk&list=RDMMMcaEBf-tAlk&start_radio=1", isUrl: true),
        ]
    ),
  ));
}
class TodosScreen extends StatelessWidget {
  final List<Todo> todos;

  TodosScreen({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('webview'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // 詳細画面に遷移する
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: todos[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Todo todo;
  DetailScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: _getBody(),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.favorite_border),
        backgroundColor: Colors.blue,
      ),
    );
  }

  _getWebview() {
    return WebView(
            initialUrl: todo.context,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
            },
          );
  }

  _getBody(){
    if (todo.isUrl == null || todo.isUrl == false) {
      if (todo.context == null){
        return Text("");
      } else{
        return Text(todo.context);
      }
    } else {
      return _getWebview();
    }
  }
}