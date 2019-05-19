String categoryQuery = """
  query category(\$id: ID) {
    category(id: \$id) {
      _id
      name
      icon
      todos {
         _id
         body
         dueDate
         status
      }
    }
  }
""";
