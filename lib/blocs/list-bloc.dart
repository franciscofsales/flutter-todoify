import 'package:rxdart/rxdart.dart';
import 'package:todoify/blocs/list-provider.dart';

class ListBloc {
  final listController = PublishSubject(); // or any other rxdart option;

  final ListProvider provider = ListProvider();

  Observable get getData => listController.stream;

  void addToList(data) {
    provider.push(data);
    listController.sink.add([provider.list, provider.currentColor]);
  }

  void setColor(color) {
    provider.setColor(color);
    listController.sink.add([provider.list, provider.currentColor]);
  }

  void dispose() {
    listController.close(); // close our StreamController to avoid memory leak
  }
}

var listBloc = ListBloc();
