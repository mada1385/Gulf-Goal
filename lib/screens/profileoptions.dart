import 'dart:io';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gulfgoal/components/profileoptioncard.dart';
import 'package:gulfgoal/components/signinchecker.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/screens/contactusscreen.dart';
import 'package:gulfgoal/screens/aboutthecomapayscreen.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/screens/termsofuse.dart';
import 'package:gulfgoal/screens/privacypolicyscreen.dart';
import 'package:gulfgoal/services/authAPI.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Profileoptions extends StatefulWidget {
  @override
  _ProfileoptionsState createState() => _ProfileoptionsState();
}

class _ProfileoptionsState extends State<Profileoptions> {
  File _image;
  bool isSwitched = false;

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  share(BuildContext context, String link) {
    final RenderBox box = context.findRenderObject();

    Share.share(link,
        subject: "check my new app",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Container(
              child: Theme(
                data: ThemeData(accentColor: accentcolor),
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(0, .75))
                      ], color: Colors.white),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Provider.of<Userprovider>(context).token == null
                              ? Signinchecher()
                              : Column(
                                  children: [
                                    Align(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.logout,
                                          color: accentcolor,
                                        ),
                                        onPressed: () async {
                                          HapticFeedback.lightImpact();
                                          await Authapi().logout(context);
                                        },
                                      ),
                                      alignment: Alignment.topRight,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await getImage();
                                        await Authapi().postimage(
                                            _image,
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .token);
                                      },
                                      child: CircleAvatar(
                                          maxRadius: 50,
                                          backgroundImage: _image != null
                                              ? FileImage(_image)
                                              : AssetImage(
                                                  "asset/nopic.jpg",
                                                )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Boldaccectcolor(
                                      text: Provider.of<Userprovider>(context,
                                              listen: false)
                                          .username,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Profileoptioncard(
                          icon: Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                              });
                            },
                            activeTrackColor: accentcolor,
                            activeColor: accentcolor,
                          ),
                          title: "دفع الاشعارات",
                        ),
                        Profileoptioncard(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Aboutthecomapayscreen()));
                          },
                          // icon: Icon(Icons.person),
                          title: "عن الشركة",
                        ),
                        Profileoptioncard(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Contactusscreen()));
                          },
                          // icon: Icon(Icons.payment),
                          title: "اتصل بنا",
                        ),
                        Profileoptioncard(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Termsofusescreen()));
                          },
                          // icon: Icon(Icons.call),
                          title: "شروط الخدمة",
                        ),
                        Profileoptioncard(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Privacypolicyscreen()));
                          },
                          // icon: Icon(Icons.payment),
                          title: "سياسة الخصوصية",
                        ),
                        Profileoptioncard(
                          // icon: Icon(Icons.payment),
                          title: "شارك التطبيق",

                          ontap: () async {
                            share(context, "share my app");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
