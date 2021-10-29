import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/modelAccount/profile.dart';
import 'package:levant/style/mainStyle.dart';

class AccountRoute extends StatefulWidget {
  const AccountRoute({Key? key}) : super(key: key);

  @override
  _AccountRouteState createState() => _AccountRouteState();
}

class _AccountRouteState extends State<AccountRoute> {
  final profile = Get.put(Profile());
  int indexTickets = 0;

  // If in the name there are space just take the first
  String getName() {
    return profile.name;
  }

  Widget accountSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 20, 16),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    (MediaQuery.of(context).size.width / 3) / 2),
                child: Image.network(
                    profile.imgProfile != ""
                        ? profile.imgProfile
                        : "https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-13.jpg",
                    fit: BoxFit.cover, loadingBuilder: (_, child, chunk) {
                  return chunk == null
                      ? child
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                }),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              getName(),
              style: MainFontsApp.poppins_black.copyWith(
                fontSize: 26,
              ),
            ),
            Text(
              profile.email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
    );
  }

  Widget ticketButton({required String title, required int i}) {
    return Expanded(
      flex: 1,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero),
          ),
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor:
              indexTickets == i ? Colors.black : Colors.transparent,
        ),
        onPressed: () {
          setState(() => indexTickets = i);
        },
        child: Text(
          title,
          style: TextStyle(
            fontWeight: indexTickets == i ? FontWeight.bold : FontWeight.w500,
            color:
                indexTickets == i ? Colors.white : Colors.black.withOpacity(.6),
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget emptyState() {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(
            indexTickets == 0
                ? "Non hai biglietti al momento"
                : "Non sei in nessuna coda al momento",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.black26,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        accountSection(),
        SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: Colors.black12, width: 2)),
          ),
          child: Row(
            children: [
              ticketButton(title: "Biglietti", i: 0),
              ticketButton(title: "Code", i: 1),
            ],
          ),
        ),
        emptyState()
      ],
    ));
  }
}
