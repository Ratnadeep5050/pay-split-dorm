class AppUser {
  String name = "";
  String phoneNumber = "";
  List<AppUser> userList = [];

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

  AppUser.makeObject();

  addDummyData() {
    userList.add(
        AppUser("Sadman", "000")
    );
    userList.add(
        AppUser("Toorja", "001")
    );
    userList.add(
        AppUser("Samir", "010")
    );
    userList.add(
        AppUser("Anika", "011")
    );
    userList.add(
        AppUser("Jaber", "100")
    );
    userList.add(
        AppUser("Sagol", "101")
    );
    userList.add(
        AppUser("Bolod", "110")
    );
    userList.add(
        AppUser("Gadha", "111")
    );
  }

  AppUser(this.name, this.phoneNumber);
}