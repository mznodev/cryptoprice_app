//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cryptoprice_app/screens/home/HomePage.dart';
import 'package:cryptoprice_app/services/auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

const users = const {
  'prueba@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};
enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class Login extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  String _email, _password;
  final auth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();

  Future<String> _authUserSignIn(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');

    return Future.delayed(loginTime).then((_) async {
      try {
        await auth.signInWithEmailAndPassword(
            email: data.name, password: data.password);
        return null;
      } on FirebaseAuthException catch (e) {
        print(e.code);
        var status;
        switch (e.code) {
          case "invalid-email":
            status = AuthResultStatus.invalidEmail;
            break;
          case "wrong-password":
            status = AuthResultStatus.wrongPassword;
            break;
          case "user-not-found":
            status = AuthResultStatus.userNotFound;
            break;
          case "user-disabled":
            status = AuthResultStatus.userDisabled;
            break;
          case "too-many-requests":
            status = AuthResultStatus.tooManyRequests;
            break;
          case "operation-not-allowed":
            status = AuthResultStatus.operationNotAllowed;
            break;
          case "email-already-in-use":
            status = AuthResultStatus.emailAlreadyExists;
            break;
          default:
            status = AuthResultStatus.undefined;
        }
        String errorMessage;
        switch (status) {
          case AuthResultStatus.invalidEmail:
            errorMessage = "Introduce un email con un formato correcto.";
            break;
          case AuthResultStatus.wrongPassword:
            errorMessage = "¡Esa no es tu contraseña! Prueba de nuevo. ;)";
            break;
          case AuthResultStatus.userNotFound:
            errorMessage = "No hay ningun usuario ascociado a ese email.";
            break;
          case AuthResultStatus.userDisabled:
            errorMessage = "Tu usuario está deshabilitado. :'(";
            break;
          case AuthResultStatus.tooManyRequests:
            errorMessage = "Demasiadas peticiones, intentelo mas tarde.";
            break;
          case AuthResultStatus.operationNotAllowed:
            errorMessage =
                "El inicio de sesion mediante Email y Contraseña esta deshabilitado, intentelo mas tarde.";
            break;
          case AuthResultStatus.emailAlreadyExists:
            errorMessage =
                "Este email ya ha sido registrado. inicia sesión o restablerce tu contraseña! :)";
            break;
          default:
            errorMessage = "A ocurrido algo, Google lo está investigando.";
        }

        return errorMessage;
      }
      return null;
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    return Future.delayed(loginTime).then((_) async {
      // Trigger the sign-in flow
      final AccessToken result =
          (await FacebookAuth.instance.login()) as AccessToken;

      // Create a credential from the access token
      final facebookAuthCredential =
          FacebookAuthProvider.credential(result.token);

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    });
  }

  Future<String> _authUserSignup(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');

    return Future.delayed(loginTime).then((_) async {
      try {
        await auth.createUserWithEmailAndPassword(
            email: data.name, password: data.password);
        return null;
      } on FirebaseAuthException catch (e) {
        print(e.code);
        var status;
        switch (e.code) {
          case "invalid-email":
            status = AuthResultStatus.invalidEmail;
            break;
          case "wrong-password":
            status = AuthResultStatus.wrongPassword;
            break;
          case "user-not-found":
            status = AuthResultStatus.userNotFound;
            break;
          case "user-disabled":
            status = AuthResultStatus.userDisabled;
            break;
          case "too-many-requests":
            status = AuthResultStatus.tooManyRequests;
            break;
          case "operation-not-allowed":
            status = AuthResultStatus.operationNotAllowed;
            break;
          case "email-already-in-use":
            status = AuthResultStatus.emailAlreadyExists;
            break;
          default:
            status = AuthResultStatus.undefined;
        }
        String errorMessage;
        switch (status) {
          case AuthResultStatus.invalidEmail:
            errorMessage = "Introduce un email con un formato correcto.";
            break;
          case AuthResultStatus.wrongPassword:
            errorMessage = "¡Esa no es tu contraseña! Prueba de nuevo. ;)";
            break;
          case AuthResultStatus.userNotFound:
            errorMessage = "No hay ningun usuario ascociado a ese email.";
            break;
          case AuthResultStatus.userDisabled:
            errorMessage = "Tu usuario está deshabilitado. :'(";
            break;
          case AuthResultStatus.tooManyRequests:
            errorMessage = "Demasiadas peticiones, intentelo mas tarde.";
            break;
          case AuthResultStatus.operationNotAllowed:
            errorMessage =
                "El inicio de sesion mediante Email y Contraseña esta deshabilitado, intentelo mas tarde.";
            break;
          case AuthResultStatus.emailAlreadyExists:
            errorMessage =
                "Este email ya ha sido registrado. inicia sesión o restablerce tu contraseña! :)";
            break;
          default:
            errorMessage = "A ocurrido algo, Google lo está investigando.";
        }

        return errorMessage;
      }
      return null;
    });
  }

  Future<String> _authUserGoogle() async {
    //print('Name: ${data.name}, Password: ${data.password}');

    return Future.delayed(loginTime).then((_) async {
      try {
        // Trigger the authentication flow
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
        print(googleUser);
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in, return the UserCredential
        await auth.signInWithCredential(credential);

        return null;
      } on FirebaseAuthException catch (e) {
        print(e.code);
        var status;
        switch (e.code) {
          case "invalid-email":
            status = AuthResultStatus.invalidEmail;
            break;
          case "wrong-password":
            status = AuthResultStatus.wrongPassword;
            break;
          case "user-not-found":
            status = AuthResultStatus.userNotFound;
            break;
          case "user-disabled":
            status = AuthResultStatus.userDisabled;
            break;
          case "too-many-requests":
            status = AuthResultStatus.tooManyRequests;
            break;
          case "operation-not-allowed":
            status = AuthResultStatus.operationNotAllowed;
            break;
          case "email-already-in-use":
            status = AuthResultStatus.emailAlreadyExists;
            break;
          default:
            status = AuthResultStatus.undefined;
        }
        String errorMessage;
        switch (status) {
          case AuthResultStatus.invalidEmail:
            errorMessage = "Introduce un email con un formato correcto.";
            break;
          case AuthResultStatus.wrongPassword:
            errorMessage = "¡Esa no es tu contraseña! Prueba de nuevo. ;)";
            break;
          case AuthResultStatus.userNotFound:
            errorMessage = "No hay ningun usuario ascociado a ese email.";
            break;
          case AuthResultStatus.userDisabled:
            errorMessage = "Tu usuario está deshabilitado. :'(";
            break;
          case AuthResultStatus.tooManyRequests:
            errorMessage = "Demasiadas peticiones, intentelo mas tarde.";
            break;
          case AuthResultStatus.operationNotAllowed:
            errorMessage =
                "El inicio de sesion mediante Email y Contraseña esta deshabilitado, intentelo mas tarde.";
            break;
          case AuthResultStatus.emailAlreadyExists:
            errorMessage =
                "Este email ya ha sido registrado. inicia sesión o restablerce tu contraseña! :)";
            break;
          default:
            errorMessage = "A ocurrido algo, Google lo está investigando.";
        }

        return errorMessage;
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'El usuario no existe';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );
    return FlutterLogin(
      title: '',
      logo: 'assets/cryptoprice.png',
      onLogin: _authUserSignIn,
      onSignup: _authUserSignup,
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          callback: () async {
            print('start google sign in');
            _authUserGoogle();
            // await Future.delayed(loginTime);
            print('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          callback: () async {
            print('start facebook sign in');
            signInWithFacebook();
            // await Future.delayed(loginTime);
            print('stop facebook sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.linkedinIn,
          callback: () async {
            print('start linkdin sign in');
            await Future.delayed(loginTime);
            print('stop linkdin sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.githubAlt,
          callback: () async {
            print('start github sign in');
            await Future.delayed(loginTime);
            print('stop github sign in');
            return null;
          },
        ),
      ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
      },
      messages: LoginMessages(
        usernameHint: 'Email',
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Confirmar',
        loginButton: 'Iniciar Sesión',
        signupButton: 'Registrarme',
        forgotPasswordButton: 'Recuperar Contraseña',
        recoverPasswordButton: 'Ayuda',
        goBackButton: 'Volver',
        confirmPasswordError: 'Las contraseñas no coinciden',
        recoverPasswordDescription:
            'Para recuperar la contraseña introduce tu email',
        recoverPasswordSuccess: '¡Contraseña recuperada satisfactoriamente! :D',
      ),
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
        errorColor: Colors.deepOrange,
        titleStyle: TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: Colors.blue,
          shadows: [Shadow(color: Colors.white, blurRadius: 2)],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        /*  inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.orange,
            color: Colors.white,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: Colors.pinkAccent,
          highlightColor: Colors.lightGreen,
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ), */
      ),
    );
  }
}
