import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/favlist.dart';
import 'package:gulfgoal/components/signinchecker.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/teams.dart';
import 'package:gulfgoal/screens/countrylistscreen.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/services/favAPI.dart';
import 'package:provider/provider.dart';

class Favoutitesscreen extends StatefulWidget {
  @override
  _FavoutitesscreenState createState() => new _FavoutitesscreenState();
}

class _FavoutitesscreenState extends State<Favoutitesscreen> {
  TextEditingController controller = new TextEditingController();
  String value = "";
  List<Teams> onSearchTextChanged(String text, List<Teams> fav) {
    List<Teams> _searchResult = [];
    _searchResult.clear();
    if (text.isEmpty) {
      return fav;
    }

    fav.forEach((userDetail) {
      if (userDetail.teamname.toUpperCase().contains(text.toUpperCase()) ||
          userDetail.teambadge.toUpperCase().contains(text.toUpperCase()))
        _searchResult.add(userDetail);
    });

    // setState(() {});
    return _searchResult;
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: new Scaffold(
        body: SafeArea(
          child: Provider.of<Userprovider>(context).token == null
              ? Center(child: Signinchecher())
              : new Column(
                  children: <Widget>[
                    new Container(
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Card(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: textcolor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: new ListTile(
                              leading: new Icon(Icons.search),
                              title: new TextField(
                                onChanged: (val) {
                                  setState(() {
                                    value = val;
                                  });
                                },
                                controller: controller,
                                decoration: new InputDecoration(
                                    hintStyle: TextStyle(
                                        fontFamily: 'cairo', fontSize: 15),
                                    hintText: 'بحث',
                                    border: InputBorder.none),
                              ),
                              trailing: new IconButton(
                                icon: new Icon(
                                  Icons.cancel,
                                  size: value == ""
                                      ? 0
                                      : SizeConfig.blockSizeVertical * 3,
                                ),
                                onPressed: () {
                                  setState(() {
                                    controller.clear();
                                    value = "";
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Boldaccectcolor(text: "الفرق المفضلة"),
                          IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Countrylistscreen()));
                              }),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: FavouriteAPI().getfavourite(
                          Provider.of<Userprovider>(context, listen: false)
                              .token), //Here we will call our getData() method,
                      builder: (context, snapshot) {
                        //the future builder is very intersting to use when you work with api
                        if (snapshot.hasData) {
                          return Favlist(
                            favteams: onSearchTextChanged(
                                controller.text, snapshot.data),
                          );
                        } else {
                          return Expanded(
                            child: Center(
                                child: Theme(
                              data: Theme.of(context)
                                  .copyWith(accentColor: accentcolor),
                              child: new CircularProgressIndicator(
                                backgroundColor: Colors.black26,
                              ),
                            )),
                          );
                        }
                      }, // here we will buil the app layout
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // onSearchTextChanged(String text) async {
  //   _searchResult.clear();
  //   if (text.isEmpty) {
  //     setState(() {});
  //     return;
  //   }

  //   favteams.forEach((userDetail) {
  //     if (userDetail.teamname.toUpperCase().contains(text.toUpperCase()) ||
  //         userDetail.teamname.toUpperCase().contains(text.toUpperCase()))
  //       _searchResult.add(userDetail);
  //   });

  //   setState(() {});
  // }
}
