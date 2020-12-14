import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';

class Lineupscreen extends StatefulWidget {
  final SoccerMatch match;

  const Lineupscreen({Key key, this.match}) : super(key: key);

  @override
  _LineupscreenState createState() => _LineupscreenState();
}

class _LineupscreenState extends State<Lineupscreen> {
  int buttonindex = 0;
  List<dynamic> home() {
    if (buttonindex == 0) {
      return widget.match.lineup.lineuphome;
    } else
      return widget.match.lineup.lineupaway;
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Column(
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 10,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 6,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        color: Colors.black12,
                        offset: Offset(0, 2.0),
                      )
                    ], borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      color: buttonindex == 0 ? textcolor2 : Colors.white,
                      onPressed: () {
                        setState(() {
                          buttonindex = 0;
                          print(buttonindex);
                        });
                      },
                      child: Text(widget.match.home.name),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 6,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.black12,
                        offset: Offset(0, .75),
                      )
                    ], borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      color: buttonindex == 1 ? textcolor2 : Colors.white,
                      onPressed: () {
                        setState(() {
                          buttonindex = 1;
                          print(buttonindex);
                        });
                      },
                      child: Text(widget.match.away.name),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Center(
            child: Text(
              "التشكيل : ${buttonindex == 0 ? widget.match.lineup.formationhome : widget.match.lineup.formationaway}",
              style: TextStyle(
                  color: textcolor2, fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Column(
                  children: home().map((e) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                      height: 75,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.black26,
                          offset: Offset(0, .75),
                        )
                      ], color: Colors.white),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${e["lineup_number"]} - ",
                                    style: TextStyle(
                                        color: textcolor2,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),

                                Text(
                                  e["lineup_player"],
                                  style: TextStyle(
                                      color: textcolor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                // Text(match.lineup.lineuphome[index]["lineup_player"]),
                              ],
                            ),
                          ),
                        ],
                      ));
                });
              }).toList()),
            ),
          ),
        ],
      ),
    );
  }
}
