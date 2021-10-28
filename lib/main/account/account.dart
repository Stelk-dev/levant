import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levant/modelAccount/profile.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class AccountRoute extends StatefulWidget {
  const AccountRoute({Key? key}) : super(key: key);

  @override
  _AccountRouteState createState() => _AccountRouteState();
}

class _AccountRouteState extends State<AccountRoute> {
  final profile = Get.put(Profile());

  // If in the name there are space just take the first
  String getName() {
    return profile.name.split(' ')[0];
  }

  Widget accountSection() {
    return TouchableOpacity(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 20, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
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
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getName(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
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
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54),
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
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: .1,
            color: Colors.black.withOpacity(.5),
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        accountSection(),
        divider(),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Change password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
        divider(),
      ],
    ));
  }
}
