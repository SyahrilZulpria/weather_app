import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:weather_app/page/weather_screen.dart';
import 'package:weather_app/util/ButtonOval.dart';
import 'package:weather_app/util/color.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureTextLogin = true;

  late ProgressDialog loading;

  void initState() {
    super.initState();

    loading = ProgressDialog(
      context,
      type: ProgressDialogType.normal,
      isDismissible: true,
      showLogs: false,
    );
    loading.style(
      progressWidget: Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator(color: colorPrimary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/cloud.png", width: 200),
                    SizedBox(height: 30),
                    Text(
                      "Weather App",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      controller: usernameController,
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15, left: 15),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: formColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: formBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: formBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: formBorder),
                        ),
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscureTextLogin,
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15, left: 15),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: formColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: formBorder),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: formBorder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: formBorder),
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: _lihatPassword,
                          child: Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              _obscureTextLogin
                                  ? "assets/icon/ic_eye600.png"
                                  : "assets/icon/ic_eye_slash.png",
                              height: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ButtonOval(
                      width: MediaQuery.of(context).size.width,
                      label: "Masuk",
                      onPressed: () {
                        FocusScope.of(
                          context,
                        ).unfocus(); // <--- add this biar ga balik fokus ke textfield
                        //HomePage();
                        print("masuk");
                        Navigator.of(context).pushReplacement(
                          CupertinoPageRoute(
                            builder: (context) => const WeatherScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _lihatPassword() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void hideLoading() {
    if (loading.isShowing()) {
      loading.hide().then((isHidden) {
        print(isHidden);
      });
    }
  }
}
