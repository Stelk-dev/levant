import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:levant/auth/service/authentication.dart';
import 'package:levant/database/database.dart';
import 'package:levant/database/storage.dart';
import 'package:levant/model/modelAccount/profile.dart';
import 'package:levant/style/mainDecoration.dart';
import 'package:levant/style/mainStyle.dart';
import 'package:levant/style/popUp.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:validators/validators.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRouteSettings extends StatefulWidget {
  const ProfileRouteSettings({Key? key}) : super(key: key);

  @override
  _ProfileRouteSettingsState createState() => _ProfileRouteSettingsState();
}

class _ProfileRouteSettingsState extends State<ProfileRouteSettings> {
  final profile = Get.put(Profile());
  bool _loadingChange = false;

  final _picker = ImagePicker();
  String img = "";

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    img = profile.imgProfile;

    _controllerName.text = profile.name;
    _controllerName.addListener(() {
      setState(() {});
    });

    _controllerEmail.text = profile.email;
    _controllerEmail.addListener(() {
      setState(() {});
    });
  }

  bool haveChange() {
    return _controllerName.text != profile.name ||
        _controllerEmail.text != profile.email ||
        img != profile.imgProfile;
  }

  Future<void> changeData() async {
    setState(() => _loadingChange = true);
    Map<String, String> dataToChange = {};
    final name = _controllerName.text;
    final email = _controllerEmail.text;

    if (name != profile.name) dataToChange.addAll({"Name": name});
    if (email != profile.email) dataToChange.addAll({"Email": email});
    if (img != profile.imgProfile) {
      // Upload image
      final idImg = File(img).hashCode.toString();
      final pathImageUser =
          Auth().idDb() + " + ${profile.name} + ${profile.email}";
      await Storage().uploadData(pathImageUser, idImg, File(img));
      img = await Storage().getData(pathImageUser, idImg);

      dataToChange.addAll({"Image": img});
    }

    try {
      await Db().updateData(Auth().idDb(), dataToChange);

      profile.changeData(n: name, e: email, img: img);
      profile.printDataProfile();

      MainPopUpStyle.flashPopUpDone(
          title: "Modifiche salvate", context: context);
    } catch (_) {
      MainPopUpStyle.flashPopUpError(
          msg: "Ops.. qualcosa è andato storto\nRiprova", context: context);
    }

    setState(() => _loadingChange = false);
  }

  void getImagePhoto({required ImageSource source}) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) return;

      final File file = File(pickedFile.path);
      setState(() => img = file.path);
      Navigator.pop(context);
    } catch (e) {
      print("Error...");
    }
  }

  Future<void> showBottomTakeImage() async {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
                color: Color.fromRGBO(16, 16, 16, 1),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Aggiungi immagine",
                                style: MainFontsApp.poppins_black.copyWith(
                                    fontSize: 18, color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                              )
                            ])),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TouchableOpacity(
                            onTap: () =>
                                getImagePhoto(source: ImageSource.camera),
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(32, 32, 32, 1),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    color: Colors.black,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.photo_camera_rounded,
                                        color: Colors.white,
                                        size: 60,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        TouchableOpacity(
                            onTap: () =>
                                getImagePhoto(source: ImageSource.gallery),
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(32, 32, 32, 1),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    color: Colors.black,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 16)
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          MainDecorationApp.appBarAndGoBackAction(
              title: "Profilo",
              context: context,
              action: haveChange() && !_loadingChange
                  ? IconButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) changeData();
                      },
                      icon: Icon(Icons.check, color: Colors.lightBlue),
                    )
                  : Container()),
          _loadingChange
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    TouchableOpacity(
                      onTap: showBottomTakeImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 3,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 6),
                                child: img.substring(0, 4) != "http"
                                    ? Image.file(
                                        File(img),
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: img != ""
                                            ? img
                                            : "https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-13.jpg",
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (_, child, chunk) =>
                                                chunk.progress == null
                                                    ? Image.network(child)
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                      ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.4),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Center(
                              child: Icon(
                                Icons.photo_camera,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                              key: _key,
                              child: Column(
                                children: [
                                  MainDecorationApp.textFormFieldFull(
                                    controller: _controllerName,
                                    hintText: "Nome",
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    validator: (s) => isLength(s!, 3)
                                        ? null
                                        : "Inserisci un nome lungo almeno tre caratteri",
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  MainDecorationApp.textFormFieldFull(
                                    controller: _controllerEmail,
                                    hintText: "Email",
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    validator: (s) => isEmail(s!)
                                        ? null
                                        : "Inserisci una email valida",
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
        ],
      ),
    );
  }
}
