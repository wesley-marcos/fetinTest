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

class Ranking extends StatefulWidget {
  Ranking({Key? key, required this.ranking}) : super(key: key);
  //final String minhaVariavel = ModalRoute.of(context)!.settings.arguments as String;
  Map<String, dynamic> ranking;

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  late Map<String, dynamic> ranking;
  late List<dynamic> rankingList;

  @override
  void initState() {
    super.initState();
    ranking = widget.ranking;
    rankingList = ranking["ranking"];
  }

  final _name_controller = TextEditingController();
  final _note_controller = TextEditingController();
  Random random = Random();

  Widget build(BuildContext context) {
    final String? variavelRecebida = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: wAppbar(
          context,
          "Ranking",
          "O ranking é definido a partir de um método "
              "matemático de decisão multicritério chamado "
              "VIKOR. Segundo esse método, a"
              " menor nota é a melhor alternativa."),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),

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
                    "Alternativa: ${rankingList[0]["Alternativa"]}\n\nNota: ${(rankingList[0]["Nota"] as double).toStringAsFixed(4)}",
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
              height: 30,
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
                    "Alternativa: ${rankingList[1]["Alternativa"]}\n\nNota: ${(rankingList[1]["Nota"] as double).toStringAsFixed(4)}",
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
              height: 30,
            ),

            Container(
              alignment: Alignment.center,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.chocolate,
                    AppColors.peru,
                    AppColors.say,
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
                    child: Image.asset("Images/3rd.png"),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Alternativa: ${rankingList[2]["Alternativa"]}\n\nNota: ${(rankingList[2]["Nota"] as double).toStringAsFixed(4)}",
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
              height: 50,
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 17.0, left: 50, right: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepSkyBlue,
                  elevation: 10,
                  fixedSize: const Size(200, 53),
                  side: const BorderSide(color: AppColors.deepSkyBlue),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(10))),
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
        ),
      ),
    );
  }

  void goToPreviousPageAndClear(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
