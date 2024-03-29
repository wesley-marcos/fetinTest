import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
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
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Ranking", style: AppTextStyles.title3),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "O ranking é definido a partir de um método "
                        "matemático de decisão multicritério chamado "
                        "VIKOR. Segundo esse método, a"
                        " menor nota é a melhor alternativa.",
                        textAlign: TextAlign.justify,
                        style: AppTextStyles.heading16NBold),
                  ),
                  actions: [
                    OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Colors.blue),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text(
          'Ranking',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(1, 2),
                blurRadius: 3,
              )
            ],
          ),
        ),
        centerTitle: true,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
      body: Consumer<Criteria>(
        builder: (BuildContext context, Criteria list, Widget? widget) {
          final criterion = list.criteria;
          final alternative = list.alternativeNames;
          int notaMaiorIni = random.nextInt(401) + 600;
          double notaMaior = notaMaiorIni / 1000.0;
          int notaMenorIni = random.nextInt(501);
          double notaMenor = notaMenorIni / 1000.0;

          return Container(
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
                          bottom: 20.0, left: 20, right: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 10,
                          fixedSize: const Size(230, 50),
                          side: const BorderSide(color: Colors.black12),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(20))),
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
                          padding: EdgeInsets.only(left: 15.0, right: 15),
                          child: Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
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
