import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todoify/components/input.dart';
import 'package:todoify/configs.dart';
import 'package:todoify/graphql/mutations/add-todo.dart';
import 'package:todoify/graphql/queries/categories.dart';

class AddTodo extends StatefulWidget {
  @override
  AddTodoState createState() => AddTodoState();
}

class AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  String _body;
  String _category;

  checkFields() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void changedDropDownItem(dynamic selectedCategory) {
    setState(() {
      _category = selectedCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: categoriesQuery,
          pollInterval: 10,
        ),
        builder: (QueryResult result, {VoidCallback refetch}) {
          if (result.errors != null || result.loading) {
            return CircularProgressIndicator();
          }

          List<DropdownMenuItem> items = new List();

          for (dynamic category in result.data["categories"]) {
            items.add(new DropdownMenuItem(
                child: Text(category["name"]), value: category["_id"]));
          }
          return Mutation(
            options: MutationOptions(document: addTodoMutation),
            builder: (RunMutation createTodo, QueryResult mutationResult) {
              return Scaffold(
                  backgroundColor: appColors[0],
                  appBar: new AppBar(
                    title: new Text(
                      'Add new Todo',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    backgroundColor: appColors[0],
                    centerTitle: true,
                    elevation: 0.0,
                  ),
                  body: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                            ),
                            Input("required field", false, "Todo Text",
                                'Enter todo text', (value) => _body = value),
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                            ),
                            DropdownButton(
                              value: _category,
                              items: items,
                              onChanged: changedDropDownItem,
                            ),
                            SizedBox(
                              width: 20.0,
                              height: 20.0,
                            ),
                            RaisedButton(
                              color: appColors[1],
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 40.0),
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                if (checkFields()) {
                                  createTodo(
                                      {"body": _body, "categoryId": _category});
                                }
                              },
                              child: Text('Submit'),
                            )
                          ]))));
            },
            onCompleted: (dynamic resultData) async {
              if (resultData != null &&
                  resultData["createTodo"] != null &&
                  resultData["createTodo"]["_id"] != null) {
                Navigator.pop(context);
              }
            },
          );
        });
  }
}
