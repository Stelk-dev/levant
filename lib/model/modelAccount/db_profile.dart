class DatabaseProfileModel {
  final String name;
  final String email;
  final String img;
  final String uid;
  final Map<String, List> tickets;

  DatabaseProfileModel(
      {required this.name,
      required this.email,
      required this.img,
      required this.uid,
      required this.tickets});

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Email": email,
      "Image": img,
      "Uid": uid,
      "Tickets": tickets,
    };
  }

  static DatabaseProfileModel fromJson({required Map<String, dynamic> data}) {
    return DatabaseProfileModel(
      name: data["Name"],
      email: data["Email"],
      img: data["Image"] ?? "",
      uid: data["Uid"],
      tickets: Map<String, List>.from(data["Tickets"]),
    );
  }
}
