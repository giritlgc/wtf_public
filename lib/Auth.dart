import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final gooleSignIn = GoogleSignIn();
final facebookSignIn = FacebookLogin();

// a simple sialog to be visible everytime some error occurs
showErrDialog(BuildContext context, String err) {
  // to hide the keyboard, if it is still p
  FocusScope.of(context).requestFocus(new FocusNode());
  return showDialog(
    context: context,
    child: AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: <Widget>[
        OutlineButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Ok"),
        ),
      ],
    ),
  );
}

// many unhandled google error exist
// will push them soon
Future<bool> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
    
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

  try {
    // if (googleSignInAccount != null) {
      // GoogleSignInAuthentication googleSignInAuthentication =
      //     await googleSignInAccount.authentication;
    
      // AuthCredential credential = GoogleAuthProvider.credential(
      //     idToken: googleSignInAuthentication.idToken,
      //     accessToken: googleSignInAuthentication.accessToken);
    
      await auth.signInWithCredential(credential);
    
      if (auth.currentUser != null) {
        return true;
      } else {
        return false;
      }
    // }
  } on FirebaseAuthException catch (e) {
    print(e.code);
  }

  return false;
}

Future<bool> signInWithFacebook() async {
  final result = await facebookSignIn.logIn(['email']);
  print(result.status);
  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      try {
        AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken.token);
        await auth.signInWithCredential(facebookCredential);
        return true;
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if(e.code == "account-exists-with-different-credential"){
          // The account already exists with a different credential
          String email = e.email;
          AuthCredential pendingCredential = e.credential;

          // Fetch a list of what sign-in methods exist for the conflicting user
          List<String> userSignInMethods = await auth.fetchSignInMethodsForEmail(email);

          if (userSignInMethods.first == 'password') {
            // Prompt the user to enter their password
            String password = '12345678';

            // Sign the user in to their account with the password
            UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: email,
              password: password,
            );

            // Link the pending credential with the existing account
            await userCredential.user.linkWithCredential(pendingCredential);

            // Success! Go back to your application flow
            return true;
          }

        }
      }
      break;
    case FacebookLoginStatus.cancelledByUser:
      return false;
      break;
    case FacebookLoginStatus.error:
      return false;
      break;
  }

  return false;
}

Future<bool> signOutUser() async {
  try {
    User user = auth.currentUser;
    if (user.providerData[0].providerId == 'google.com') {
      await gooleSignIn.disconnect();
    } else if (user.providerData[0].providerId == 'facebook.com') {
      print(user.providerData[0].providerId);
      await facebookSignIn.logOut();
    }

    await auth.signOut();
  } on Exception catch (e) {
    print(e);
  }

  return Future.value(true);
}

