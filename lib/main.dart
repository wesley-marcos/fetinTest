import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/appColors.dart';
import 'package:hash_test/components/alternatives.dart';
import 'package:hash_test/components/criteria.dart';
import 'package:hash_test/http/input.dart';
import 'package:hash_test/screens/alternatives/alternatives_input.dart';
import 'package:hash_test/screens/criterios/home.dart';
import 'package:hash_test/screens/ranking.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => Alternatives(alternatives: [])),
      ChangeNotifierProvider(
          create: (context) => Criteria(criteria: [], alternativeNames: []))
    ],
    child: const MyApp(),
  ));
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //final BuildContext CriterionCont;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.deepSkyBlue),
        useMaterial3: true,
      ),
      //home: //InputAlternatives(),
      initialRoute: 'Alternativas',
      routes: {
        'Alternativas': (BuildContext context) => const InputAlternatives(),
        'Critérios': (BuildContext context) => const Home(),
        'Ranking': (BuildContext context) => Ranking(ranking: {},),
      },
    );
  }
}
