String addTodoMutation = """
  mutation createTodo(\$body: String!, \$categoryId: String!) {
    createTodo(input: {body: \$body, categoryId: \$categoryId}) {
       _id
       body
    }
  }
""";
