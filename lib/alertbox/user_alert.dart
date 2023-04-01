import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/fechdata.dart';

class UserAlert extends StatelessWidget {
  UserAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Fetchdata>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              height: 200,
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFilds(provider.name, "Enter name"),
                    SizedBox(
                      height: 10,
                    ),
                    TextFilds(provider.note, "Enter Note"),
                    ElevatedButton(
                        onPressed: () {
                          if (provider.isupdate == true) {
                            provider.Updatedata();
                          } else {
                            provider.Addnote();
                          }

                          Navigator.pop(context);
                        },
                        child: Text("Submit"))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget TextFilds(TextEditingController mycon, String hinttext) {
    return TextFormField(
      controller: mycon,
      //editing controller of this TextField
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 10),
        //  fillColor: Color(0xFFEBF3FF),
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFFCDDBEF)),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFCDDBEF), width: 1),
        ),
        hintText: (hinttext),
        //   hintStyle: //,
        //  suffixIcon: Icon(Icons.arrow_drop_down),
      ),
    );
  }
}
