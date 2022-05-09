class User {
  String firstName;
  String lastName;

  List<User> users;
   User({required this.firstName, required this.lastName,required this.users});

  static List<User> getUsers() {
    return <User>[
      User(firstName: "Aaron", lastName: "Jackson", users: []),
      User(firstName: "Ben", lastName: "John", users: []),
      User(firstName: "Carrie", lastName: "Brown", users: []),
      User(firstName: "Deep", lastName: "Sen", users: []),
      User(firstName: "Emily", lastName: "Jane", users: []),
    ];
  }
}
