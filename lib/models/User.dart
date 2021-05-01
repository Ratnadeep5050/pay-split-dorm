class User {
  String name = "";
  String phoneNumber = "";
  List<User> userList = [
    User("Sadman", "000"),
    User("Toorja", "001"),
    User("Samir", "010"),
    User("Anika", "011"),
    User("Jaber", "100"),
    User("Sagol", "101"),
    User("Bolod", "110"),
    User("Gadha", "111"),
  ];

  User(this.name, this.phoneNumber);
}