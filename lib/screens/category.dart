// A Widget that extracts the necessary arguments from the ModalRoute.
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todoify/components/category-header.dart';
import 'package:todoify/configs.dart';
import 'package:todoify/graphql/mutations/update-todo-status.dart';
import 'package:todoify/graphql/queries/category.dart';

class CategoryScreenArguments {
  final String id;
  CategoryScreenArguments(this.id);
}

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    final Color color = appColors[new Random().nextInt(appColors.length)];
    return Query(
      options: QueryOptions(
          document: categoryQuery,
          variables: {"id": args.id},
          pollInterval: 10),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.errors != null || result.loading) {
          return CircularProgressIndicator();
        }
        return Mutation(
          options: MutationOptions(document: updateTodoStatusMutation),
          builder: (RunMutation updateTodoStatus, QueryResult mutationResult) {
            result.data["category"]["todos"].sort((a, b) {
              if (a["status"] == "TODO") {
                return -1;
              } else if (b["status"] == "TODO") {
                return 1;
              } else if (a["status"] == "COMPLETED") {
                return -1;
              }
              return 1;
            });

            return Scaffold(
                appBar: new AppBar(
                  title: new Text(
                    result.data["category"]["name"],
                    style: TextStyle(fontSize: 16.0),
                  ),
                  backgroundColor: color,
                  centerTitle: true,
                  elevation: 0.0,
                ),
                body: Column(
                  children: <Widget>[
                    CategoryHeader(
                        category: result.data["category"], color: color),
                    new Expanded(
                        child: ListView.builder(
                      itemCount: result.data["category"]["todos"].length,
                      itemBuilder: (context, index) {
                        var todo = result.data["category"]["todos"][index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Text(
                                todo["body"],
                                style: TextStyle(
                                    decoration: todo["status"] != "TODO"
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: todo["status"] == "ARCHIVED"
                                        ? Color.fromRGBO(0, 0, 0, 0.3)
                                        : Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: todo["status"] == "ARCHIVED"
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(todo["status"] == "COMPLETED"
                                          ? Icons.archive
                                          : Icons.done),
                                      onPressed: () {
                                        updateTodoStatus({
                                          "todoId": todo["_id"],
                                          "status":
                                              todo["status"] == "COMPLETED"
                                                  ? "ARCHIVED"
                                                  : "COMPLETED"
                                        });
                                      }),
                            )
                          ],
                        );
                      },
                    )),
                  ],
                ));
          },
          onCompleted: (dynamic resultData) async {
            if (resultData != null &&
                resultData["markDone"] != null &&
                resultData["markDone"]["_id"] != null) {
              refetch();
            }
          },
        );
      },
    );
  }
}
