String categoriesQuery = """
  query categories {
    categories {
      _id
      name
      icon
      taskCompletion
      tasksRemaining
    }
  }
""";
