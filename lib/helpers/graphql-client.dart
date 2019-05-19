import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphQLClientHelper {
  static final HttpLink httpLink = HttpLink(
    uri: 'http://localhost:8080/graphql',
  );

  static final AuthLink authLink = AuthLink(
    getToken: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('authToken');
    },
  );

  static final Link link = authLink.concat(httpLink as Link);

  static final ValueNotifier<GraphQLClient> graphqlClient = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );
}
