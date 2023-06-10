import 'package:flutter/material.dart';

import 'alternatives_input.dart';
import '../basic_templates/appColors.dart';
import '../basic_templates/app_text_styles.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              AppColors.deepSkyBlue,
              AppColors.lightSkyBlue,
              AppColors.lightBlue,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
          padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
          alignment: Alignment.center,
          child: ListView(
            children: [
              //Language(),

              const SizedBox(
                width: 20,
                height: 1,
              ),

              Container(
                alignment: Alignment.center,
                child: Text(
                  "Bem vindo!",
                  style: AppTextStyles.title,
                ),
              ),

              const SizedBox(
                width: 20,
                height: 20,
              ),

              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("Images/man_profile.png",
                    alignment: Alignment.center),
              ),

              const SizedBox(
                width: 20,
                height: 200,
              ),

              Padding(
                padding:
                    const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 10,
                    fixedSize: const Size(230, 50),
                    side: const BorderSide(color: Colors.black12),
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(20))),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InputAlternatives()),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15),
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                width: 20,
                height: 40,
              ),

              //HistoricButton(),
            ],
          ),
        ));
  }
}
