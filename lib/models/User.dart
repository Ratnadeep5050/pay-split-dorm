class User {
  String name = "";
  String phoneNumber = "";
  List<User> userList = [];

  /*
    User(name: "Sadman", phoneNumber: "000")
    User("Sadman", "000"),
    User("Toorja", "001"),
    User("Samir", "010"),
    User("Anika", "011"),
    User("Jaber", "100"),
    User("Sagol", "101"),
    User("Bolod", "110"),
    User("Gadha", "111"),

     */

  User.makeObject();

  addDummyData() {
    userList.add(
        User("Sadman", "000")
    );
    userList.add(
        User("Toorja", "001")
    );
    userList.add(
        User("Samir", "010")
    );
    userList.add(
        User("Anika", "011")
    );
    userList.add(
        User("Jaber", "100")
    );
    userList.add(
        User("Sagol", "101")
    );
    userList.add(
        User("Bolod", "110")
    );
    userList.add(
        User("Gadha", "111")
    );
  }

  User(this.name, this.phoneNumber);
}