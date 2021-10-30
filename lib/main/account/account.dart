import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
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

  Widget accountSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  (MediaQuery.of(context).size.width / 3) / 2),
              child: CachedNetworkImage(
                imageUrl: profile.imgProfile != ""
                    ? profile.imgProfile
                    : "https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-13.jpg",
                fit: BoxFit.cover,
                progressIndicatorBuilder: (_, child, chunk) =>
                    chunk.progress == null
                        ? Image.network(child)
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            profile.name,
            style: MainFontsApp.poppins_black.copyWith(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          Text(
            profile.email,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
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

  Widget ticketButton(
      {required String title, required IconData icon, required int i}) {
    return Expanded(
      flex: 1,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero),
          ),
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: indexTickets == i ? Colors.black : Colors.white,
        ),
        onPressed: () {
          setState(() => indexTickets = i);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: indexTickets == i ? Colors.white : Colors.grey),
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight:
                    indexTickets == i ? FontWeight.bold : FontWeight.w500,
                color: indexTickets == i
                    ? Colors.white
                    : Colors.black.withOpacity(.6),
                fontSize: 17,
              ),
            ),
          ],
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: false,
          pinned: true,
          snap: false,
          expandedHeight: 300,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: accountSection(),
            centerTitle: true,
            titlePadding: EdgeInsets.zero,
            collapseMode: CollapseMode.none,
          ),
          bottom: PreferredSize(
            child: Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Colors.black12,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  ticketButton(
                      title: "Biglietti", icon: FlutterIcons.ticket_ent, i: 0),
                  ticketButton(title: "Code", icon: Icons.access_time, i: 1),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(0),
          ),
        ),
        SliverFillRemaining(
          child: emptyState(),
        ),
      ],
    );
  }
}
