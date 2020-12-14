import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/matchtile.dart';
import 'package:gulfgoal/components/teamcard.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:gulfgoal/screens/lineupscreen.dart';
import 'package:gulfgoal/screens/statsscreen.dart';

import 'nointernetscreen.dart';

class MatchDetailsScreen extends StatefulWidget {
  final SoccerMatch match;

  const MatchDetailsScreen({Key key, this.match}) : super(key: key);
  @override
  _MatchDetailsScreenState createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  int tapindex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> detailscreen = [
      Statsscreen(
        match: widget.match,
      ),
      Lineupscreen(
        match: widget.match,
      ),
    ];
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        backgroundColor: Colors.white,
        // drawer: IconButton(
        //   icon: Icon(Icons.sanitizer, size: 50),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        body: SafeArea(
          child: Theme(
            data: ThemeData(accentColor: accentcolor),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 1.0))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  height: SizeConfig.blockSizeVertical * 25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        widget.match.fixture.status.league,
                        style: TextStyle(fontSize: 15, color: textcolor),
                      ),
                      Container(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Teamcard(
                                logourl: widget.match.home.logoUrl,
                                teamname: widget.match.home.name,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${widget.match.goal.home} : ${widget.match.goal.away}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: accentcolor,
                                  fontSize: SizeConfig.blockSizeVertical * 5,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Teamcard(
                                logourl: widget.match.away.logoUrl,
                                teamname: widget.match.away.name,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          child: SizedBox(
                        height: 20,
                      )),
                      Text(
                        widget.match.fixture.status.status == ""
                            ? widget.match.fixture.time
                            : widget.match.fixture.status.status,
                        style: TextStyle(fontSize: 20, color: textcolor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                tapindex = 0;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: tapindex == 0
                                              ? accentcolor
                                              : Colors.transparent,
                                          width: 4))),
                              child: Text(
                                "الاحصائيات",
                                style: TextStyle(
                                    color: textcolor,
                                    fontSize: 20,
                                    fontFamily: 'cairo'),
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                tapindex = 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: tapindex == 1
                                              ? accentcolor
                                              : Colors.transparent,
                                          width: 4))),
                              child: Text(
                                "التشكيل",
                                style: TextStyle(
                                    color: textcolor,
                                    fontSize: 20,
                                    fontFamily: 'cairo'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: detailscreen[tapindex],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
