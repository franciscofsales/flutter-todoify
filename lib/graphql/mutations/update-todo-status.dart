String updateTodoStatusMutation = """
  mutation updateTodo(\$todoId: String!, \$status: String!) {
    updateTodo(input: {todoId: \$todoId, status: \$status}) {
       _id
       body
       status
    }
  }
""";
