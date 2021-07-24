import 'package:evaluation_task/Model/response_from_api.dart';
import 'package:evaluation_task/Utils/navigation.dart';
import 'package:evaluation_task/Utils/size_config.dart';
import 'package:evaluation_task/Utils/time_helper.dart';

import 'package:evaluation_task/Utils/sharedpreference_helper.dart';
import 'package:evaluation_task/Utils/user.dart';
import 'package:evaluation_task/webservices/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeViewModeltate createState() => _HomeViewModeltate();
}

class _HomeViewModeltate extends State<HomeScreen> {
  final repository = Repository();
  Future<ResponseFromApi> getData() async {
    var response = await repository.getData();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var greetingText = TimeHelper.getTextForGreeting(DateTime.now());

    return Scaffold(
        appBar: AppBar(
          title: Text("Medications"),
          actions: [
            IconButton(
                onPressed: () {
                  try {
                    showDialog(
                        context: (context),
                        builder: (BuildContext context) => Container(
                              child: Center(
                                child: SpinKitWave(
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                              ),
                            ));
                    FirebaseAuth.instance.signOut();
                    userName = '';
                    userid = '';
                    SharedPreferenceHelper.clear();
                    NavigationService.instance
                        .navigateToPushAndRemoveUntilRoute("/login");
                    Fluttertoast.showToast(msg: "Logged out succesfully");
                  } catch (e) {
                    Fluttertoast.showToast(msg: e.toString());
                  }
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kToolbarHeight / 2, horizontal: 21),
          child: Column(
            children: [
              Text(
                "$greetingText , $userName",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 11,
              ),
              FutureBuilder(
                future: getData(),
                builder: (BuildContext context,
                    AsyncSnapshot<ResponseFromApi> snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.problems![0].diabetes![0]
                        .medications![0].medicationsClasses![0];
                    return
                        //  ListView.builder(
                        //     itemCount: snapshot.data!.problems![0].diabetes![0]
                        //         .medications![0].medicationsClasses!.length,
                        //     shrinkWrap: true,
                        //     itemBuilder: (BuildContext context, int index) {
                        // var data = snapshot
                        //     .data!
                        //     .problems![index]
                        //     .diabetes![index]
                        //     .medications![index]
                        //     .medicationsClasses![index];
                        //       return
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text("Name: " +
                              data.className![0].associatedDrug![0].name!),
                          Text("Dose: " +
                              data.className![0].associatedDrug![0].dose!),
                          Text("Strength: " +
                              data.className![0].associatedDrug![0].strength!),
                          Divider(),
                          Text("Name: " +
                              data.className![0].associatedDrug2![0].name!),
                          Text("Dose: " +
                              data.className![0].associatedDrug2![0].dose!),
                          Text("Strength: " +
                              data.className![0].associatedDrug2![0].strength!),
                          Divider(),
                          Text("Name: " +
                              data.className2![0].associatedDrug![0].name!),
                          Text("Dose: " +
                              data.className2![0].associatedDrug![0].dose!),
                          Text("Strength: " +
                              data.className2![0].associatedDrug![0].strength!),
                          Divider(),
                          Text("Name: " +
                              data.className2![0].associatedDrug2![0].name!),
                          Text("Dose: " +
                              data.className2![0].associatedDrug2![0].dose!),
                          Text("Strength: " +
                              data.className2![0].associatedDrug2![0]
                                  .strength!),
                        ]);
                    // });
                  } else {
                    return Center(
                      child: SpinKitChasingDots(
                        color: kPrimaryColor,
                        size: 35,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
