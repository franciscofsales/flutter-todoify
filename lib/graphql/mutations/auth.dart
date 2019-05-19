String authMutation = """
  mutation auth(\$email: String!, \$password: String!) {
    auth(input: {email: \$email, password: \$password}) {
       access
       refresh
       userId
       userName
    }
  }
""";
