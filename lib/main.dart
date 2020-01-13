import 'package:flutter/material.dart';
import 'package:rapido/rapido.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapido Demo',
      home: RapidoExample(title: 'Rapdio'),
    );
  }
}

class RapidoExample extends StatefulWidget {
  RapidoExample({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RapidoExampleState createState() => _RapidoExampleState();
}

class _RapidoExampleState extends State<RapidoExample> {
  final DocumentList documentList = DocumentList(
    "task list",
    labels: {"開始日": "date", "タイトル": "task", "優先度": "pri count", "ノート": "note"},
  );

  @override
  Widget build(BuildContext context) {
    return DocumentListScaffold(
      documentList,
      title: "タスク",
      titleKeys: ["date", "task", "pri count"],
      subtitleKey: "note",
      customItemBuilder: _customBuilder,
      emptyListWidget: Center(
        child: Text(
          "ボタンを押してタスクを追加",
          textAlign: TextAlign.center,
        ),
      ),
      decoration: BoxDecoration(color: Colors.orange),
    );
  }

  Widget _customBuilder(int index, Document doc, BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(documentList[index]["pri count"].toString(),
                style: Theme.of(context).textTheme.display1),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(documentList[index]["task"],
                    style: Theme.of(context).textTheme.title),
                Text(documentList[index]["date"].toString()),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(documentList[index]["note"]),
                )
              ],
            ),
          ),
          DocumentActionsButton(documentList, index: index)
        ],
      ),
      color: _calculateColor(documentList[index]["pri count"]),
    );
  }

  Color _calculateColor(int priority) {
    if (priority < 3) {
      return Colors.red;
    } else if (priority < 7) {
      return Colors.yellow;
    }
    return Colors.green;
  }
}