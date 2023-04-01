import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alertbox/user_alert.dart';
import 'provider/fechdata.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Fetchdata>(
      builder: (context, provider, child) {
        provider.getdata();
        return Scaffold(
          appBar: AppBar(
            title: Text("Sqlite"),
            actions: [
              IconButton(
                  onPressed: () {
                    provider.isupdate = false;
                    provider.note.clear();
                    provider.name.clear();
                    _showMyDialog();
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          body: SafeArea(
            child: ListView(
              children: provider.mydata! == 0
                  ? [
                      Container(
                        child: Text("Data Not Found"),
                      )
                    ]
                  : [
                      for (int i = 0; i < provider.mydata!.length; i++) ...[
                        ListTile(
                          title: Text(provider.mydata![i]['name'].toString()),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(provider.mydata![i]['note'].toString()),
                              IconButton(
                                onPressed: () {
                                  provider.updateid =
                                      provider.mydata![i]['id'].toString();
                                  provider.isupdate = true;
                                  provider.name.text =
                                      provider.mydata![i]['name'].toString();
                                  provider.note.text =
                                      provider.mydata![i]['note'].toString();
                                  _showMyDialog();
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Widget cancelButton = ElevatedButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              );
                              Widget continueButton = ElevatedButton(
                                child: Text("Continue"),
                                onPressed: () {
                                  provider.deletedata(
                                      provider.mydata![i]['id'].toString());
                                  Navigator.pop(context);
                                },
                              );
                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("Warning"),
                                content: Text("Are You Sure Want to Delete"),
                                actions: [
                                  cancelButton,
                                  continueButton,
                                ],
                              );
                              // show the dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                            icon: Icon(Icons.highlight_remove_outlined),
                          ),
                        )
                      ]
                    ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 80.0, right: 20, left: 20, bottom: 200),
                child: UserAlert(),
              );
            },
          );
        });
  }
}
