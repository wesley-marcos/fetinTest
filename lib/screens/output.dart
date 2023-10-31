import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
import 'package:hash_test/components/appBar.dart';
import 'package:hash_test/screens/initial_screen.dart';
import 'package:hash_test/components/criteria.dart';
import 'package:provider/provider.dart';
import '../basic_templates/appColors.dart';
import '../components/alternative.dart';
import 'dart:math';

class Output extends StatefulWidget {
  const Output({Key? key}) : super(key: key);

  //final BuildContext CriterionCont;

  @override
  State<Output> createState() => _OutputState();
}

class _OutputState extends State<Output> {
  @override
  final _name_controller = TextEditingController();
  final _note_controller = TextEditingController();
  Random random = Random();

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: wAppbar(
          context,
          "Ranking",
          "O ranking é definido a partir de um método "
              "matemático de decisão multicritério chamado "
              "VIKOR. Segundo esse método, a"
              " menor nota é a melhor alternativa."),
      body: Consumer<Criteria>(
        builder: (BuildContext context, Criteria list, Widget? widget) {
          final criterion = list.criteria;
          final alternative = list.alternativeNames;
          int notaMaiorIni = random.nextInt(401) + 600;
          double notaMaior = notaMaiorIni / 1000.0;
          int notaMenorIni = random.nextInt(501);
          double notaMenor = notaMenorIni / 1000.0;

          return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
            alignment: Alignment.center,
            child: ListView.builder(
              itemCount: list.criteria.length,
              itemBuilder: (context, index) {
                final criterion = list.criteria[index];
                //final alternative = list.alternatives[index];
                Alternative alternative = criterion.alternatives[0];
                Alternative alternative1 = criterion.alternatives[1];
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    //for (Alternative alternative in criterion.alternatives)
                    // Container(
                    // alignment: Alignment.center,
                    // height: 150,
                    // decoration: BoxDecoration(
                    // gradient: const LinearGradient(
                    // colors: [
                    // AppColors.khaki,
                    // AppColors.yellow,
                    // AppColors.gold,
                    // ],
                    // begin: Alignment.bottomCenter,
                    // end: Alignment.topCenter,
                    // ),
                    // borderRadius: BorderRadius.circular(20),
                    // ),
                    // // child: Row(
                    // //   mainAxisAlignment: MainAxisAlignment.start,
                    // //   crossAxisAlignment: CrossAxisAlignment.center,
                    // //   children: [
                    // //     Container(
                    // //       alignment: Alignment.center,
                    // //       height: 100,
                    // //       width: 100,
                    // //       child: Image.asset("Images/1st.png"),
                    // //     ),
                    // //     const SizedBox(
                    // //       width: 30,
                    // //     ),
                    // //     Text(
                    // //       "Alternativa: ${alternative.name[0]}"
                    // //           "\nNota:"
                    // //           " ${notaMenor}",
                    // //       style: TextStyle(
                    // //         color: Colors.black,
                    // //         fontWeight: FontWeight.bold,
                    // //         fontSize: 20,
                    // //       ),
                    // //     ),
                    // //   ],
                    // // ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),

                    if (criterion.alternatives.isNotEmpty)
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.khaki,
                              AppColors.yellow,
                              AppColors.gold,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              child: Image.asset("Images/1st.png"),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Alternativa: \n${alternative.name}\n\nNota: ${notaMenor}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    //else
                    //   // Caso não haja alternativas, você pode exibir alguma mensagem alternativa ou
                    //   // deixar esse espaço em branco.
                    //   Container(),

                    const SizedBox(
                      height: 50,
                    ),

                    // for (Alternative alternative in criterion.alternatives)
                    Container(
                      alignment: Alignment.center,
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.gainsboro,
                            AppColors.lighsilver,
                            AppColors.silver,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 100,
                            child: Image.asset("Images/2nd.png"),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Alternativa: \n${alternative1.name}"
                            "\n\nNota: ${notaMaior}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 210,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 17.0, left: 50, right: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepSkyBlue,
                          elevation: 10,
                          fixedSize: const Size(200, 53),
                          side: const BorderSide(color: AppColors.deepSkyBlue),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(10))),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InitialScreen()),
                            (route) => false,
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  void goToPreviousPageAndClear(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
