import 'package:elredtodo/app/core/utils/constant.dart';
import 'package:elredtodo/app/core/utils/router.dart';
import 'package:elredtodo/app/data/services/authservice.dart';
import 'package:elredtodo/app/modules/home/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

loginLogOutDialog(BuildContext context, {bool logOut = false}) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          logOut ? 'Google Log Out' : 'Google SignIn',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        children: <Widget>[
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: () {
              AuthService auth =
                  Provider.of<AuthService>(context, listen: false);
              if (!logOut) {
                auth.signInWithGoogle().then((v) => Provider.of<HomeProvider>(
                        navigatorKey.currentContext!,
                        listen: false)
                    .fetchTodoData(fromLogin: true));

                context.pop();
              } else {
                auth.signOut().then((value) => Provider.of<HomeProvider>(
                        navigatorKey.currentContext!,
                        listen: false)
                    .removeTodoData());

                context.pop();
              }
            },
            icon: Image.network("https://i.ibb.co/YQC1gJ9/google.png",
                height: 30),
            label: Text(
              logOut ? "Log Out" : "Sign in with Google",
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      );
    },
  );
}
