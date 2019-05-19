import 'package:rxdart/rxdart.dart';
import 'package:todoify/blocs/ui-provider.dart';

class UIBloc {
  final uiController = PublishSubject(); // or any other rxdart option;

  final UIProvider provider = UIProvider();

  Observable get getData => uiController.stream;

  void setColor(color) {
    provider.setColor(color);
    uiController.sink.add([provider.currentColor]);
  }

  void dispose() {
    uiController.close(); // close our StreamController to avoid memory leak
  }
}

var uiBloc = UIBloc();
