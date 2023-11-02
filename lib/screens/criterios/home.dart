import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
import 'package:hash_test/components/alternative.dart';
import 'package:hash_test/components/appBar.dart';
import 'package:hash_test/components/buttonProximo.dart';
import 'package:hash_test/components/criteria.dart';
import 'package:hash_test/components/floatActionButton.dart';
import 'package:hash_test/components/showDialog.dart';
import 'package:hash_test/screens/criterios/criteriosView.dart';
import 'package:hash_test/utils/validations_mixin.dart';
import 'package:provider/provider.dart';
import '../../basic_templates/appColors.dart';
import '../ranking.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with ValidationsMixin {
  // Definindo as 'Keys' utilizadas
  final _keyNome = GlobalKey<FormFieldState>();
  final _keyPeso = GlobalKey<FormFieldState>();

  // Definindo as 'keys' das notas do Critério 1
  final _keyN1A1C1 = GlobalKey<FormFieldState>();
  final _keyN2A1C1 = GlobalKey<FormFieldState>();
  final _keyN3A1C1 = GlobalKey<FormFieldState>();
  final _keyN1A2C1 = GlobalKey<FormFieldState>();
  final _keyN2A2C1 = GlobalKey<FormFieldState>();
  final _keyN3A2C1 = GlobalKey<FormFieldState>();
  final _keyN1A3C1 = GlobalKey<FormFieldState>();
  final _keyN2A3C1 = GlobalKey<FormFieldState>();
  final _keyN3A3C1 = GlobalKey<FormFieldState>();
  final _keyN1A4C1 = GlobalKey<FormFieldState>();
  final _keyN2A4C1 = GlobalKey<FormFieldState>();
  final _keyN3A4C1 = GlobalKey<FormFieldState>();
  final _keyN1A5C1 = GlobalKey<FormFieldState>();
  final _keyN2A5C1 = GlobalKey<FormFieldState>();
  final _keyN3A5C1 = GlobalKey<FormFieldState>();
  final _keyN1A6C1 = GlobalKey<FormFieldState>();
  final _keyN2A6C1 = GlobalKey<FormFieldState>();
  final _keyN3A6C1 = GlobalKey<FormFieldState>();

  // Definindo as 'keys' das notas do Critério 2
  final _keyN1A1C2 = GlobalKey<FormFieldState>();
  final _keyN2A1C2 = GlobalKey<FormFieldState>();
  final _keyN3A1C2 = GlobalKey<FormFieldState>();
  final _keyN1A2C2 = GlobalKey<FormFieldState>();
  final _keyN2A2C2 = GlobalKey<FormFieldState>();
  final _keyN3A2C2 = GlobalKey<FormFieldState>();
  final _keyN1A3C2 = GlobalKey<FormFieldState>();
  final _keyN2A3C2 = GlobalKey<FormFieldState>();
  final _keyN3A3C2 = GlobalKey<FormFieldState>();
  final _keyN1A4C2 = GlobalKey<FormFieldState>();
  final _keyN2A4C2 = GlobalKey<FormFieldState>();
  final _keyN3A4C2 = GlobalKey<FormFieldState>();
  final _keyN1A5C2 = GlobalKey<FormFieldState>();
  final _keyN2A5C2 = GlobalKey<FormFieldState>();
  final _keyN3A5C2 = GlobalKey<FormFieldState>();
  final _keyN1A6C2 = GlobalKey<FormFieldState>();
  final _keyN2A6C2 = GlobalKey<FormFieldState>();
  final _keyN3A6C2 = GlobalKey<FormFieldState>();

  // Definindo as 'keys' das notas do Critério 3
  final _keyN1A1C3 = GlobalKey<FormFieldState>();
  final _keyN2A1C3 = GlobalKey<FormFieldState>();
  final _keyN3A1C3 = GlobalKey<FormFieldState>();
  final _keyN1A2C3 = GlobalKey<FormFieldState>();
  final _keyN2A2C3 = GlobalKey<FormFieldState>();
  final _keyN3A2C3 = GlobalKey<FormFieldState>();
  final _keyN1A3C3 = GlobalKey<FormFieldState>();
  final _keyN2A3C3 = GlobalKey<FormFieldState>();
  final _keyN3A3C3 = GlobalKey<FormFieldState>();
  final _keyN1A4C3 = GlobalKey<FormFieldState>();
  final _keyN2A4C3 = GlobalKey<FormFieldState>();
  final _keyN3A4C3 = GlobalKey<FormFieldState>();
  final _keyN1A5C3 = GlobalKey<FormFieldState>();
  final _keyN2A5C3 = GlobalKey<FormFieldState>();
  final _keyN3A5C3 = GlobalKey<FormFieldState>();
  final _keyN1A6C3 = GlobalKey<FormFieldState>();
  final _keyN2A6C3 = GlobalKey<FormFieldState>();
  final _keyN3A6C3 = GlobalKey<FormFieldState>();

  // bool _isLoading = false;

  int numberOfCriteria = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool showInstruction = true; // Variável para controlar a exibição da mensagem

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: wAppbar(
          context,
          "Criterios",
          "Aqui você entra com os "
              "critérios importantes na hora "
              "de tomar sua decisão."),
      body: Consumer<Criteria>(
        builder: (BuildContext context, Criteria list, Widget? widget) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              top: 10,
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                if (showInstruction)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 250,
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        "Aqui você entra com os "
                        "critérios importantes na hora "
                        "de tomar sua decisão.",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: list.criteria.length,
                    itemBuilder: (context, index) {
                      final color = index % 2 == 0
                          ? AppColors.lightSkyBlue.withOpacity(0.5)
                          : Colors.white.withOpacity(0.5);
                      final criterion = list.criteria[index];

                      return wCriteriosView(color, criterion, "Critério",
                          "Peso", "Alternativa", "Nota");
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                wButtonProximo(
                  context,
                  "Aviso",
                  "Adicione pelo menos 2 critérios antes de "
                      "prosseguir.",
                  const Ranking(),
                  false,
                  () {
                    // Validar se há pelo menos 2 alternativas
                    if (Provider.of<Criteria>(context, listen: false)
                            .criteria
                            .length <
                        2) {
                      wShowDialog(
                          context,
                          "Aviso",
                          "Adicione pelo menos 2 critérios antes de "
                              "prosseguir.");
                    } else {
                      String jsonCriteria = list.toJson();
                      print(jsonCriteria);

                      _showLoadingDialog(
                          context); // Exibir o showDialog do loading

                      // Atraso de 1 segundo
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pop(
                            context); // Fechar o showDialog do loading

                        // Navegar para a próxima tela
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Ranking()),
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: wFloatActionButton(
        context,
        "Limite atingido",
        "Você atingiu o limite de 3 critérios.",
        numberOfCriteria,
        createCriteria,
        increment,
        3,
      ),
    );
  }

  void increment() {
    numberOfCriteria++;
  }

  void createCriteria(context) {
    // Definindo os controladores dos TextFormFields
    final nomeInput = TextEditingController();
    final pesoInput = TextEditingController();

    List<String> notas = [];
    Map<String, Map<String, String>> notasMap = {};

    // Definindo os controladores de notas do critério 1
    final note1Alternativa1Criterio1 = TextEditingController();
    final note2Alternativa1Criterio1 = TextEditingController();
    final note3Alternativa1Criterio1 = TextEditingController();

    final note1Alternativa2Criterio1 = TextEditingController();
    final note2Alternativa2Criterio1 = TextEditingController();
    final note3Alternativa2Criterio1 = TextEditingController();

    final note1Alternativa3Criterio1 = TextEditingController();
    final note2Alternativa3Criterio1 = TextEditingController();
    final note3Alternativa3Criterio1 = TextEditingController();

    final note1Alternativa4Criterio1 = TextEditingController();
    final note2Alternativa4Criterio1 = TextEditingController();
    final note3Alternativa4Criterio1 = TextEditingController();

    final note1Alternativa5Criterio1 = TextEditingController();
    final note2Alternativa5Criterio1 = TextEditingController();
    final note3Alternativa5Criterio1 = TextEditingController();

    final note1Alternativa6Criterio1 = TextEditingController();
    final note2Alternativa6Criterio1 = TextEditingController();
    final note3Alternativa6Criterio1 = TextEditingController();

    // Definindo os controladores de notas do critério 2
    final note1Alternativa1Criterio2 = TextEditingController();
    final note2Alternativa1Criterio2 = TextEditingController();
    final note3Alternativa1Criterio2 = TextEditingController();

    final note1Alternativa2Criterio2 = TextEditingController();
    final note2Alternativa2Criterio2 = TextEditingController();
    final note3Alternativa2Criterio2 = TextEditingController();

    final note1Alternativa3Criterio2 = TextEditingController();
    final note2Alternativa3Criterio2 = TextEditingController();
    final note3Alternativa3Criterio2 = TextEditingController();

    final note1Alternativa4Criterio2 = TextEditingController();
    final note2Alternativa4Criterio2 = TextEditingController();
    final note3Alternativa4Criterio2 = TextEditingController();

    final note1Alternativa5Criterio2 = TextEditingController();
    final note2Alternativa5Criterio2 = TextEditingController();
    final note3Alternativa5Criterio2 = TextEditingController();

    final note1Alternativa6Criterio2 = TextEditingController();
    final note2Alternativa6Criterio2 = TextEditingController();
    final note3Alternativa6Criterio2 = TextEditingController();

    // Definindo os controladores de notas do critério 3
    final note1Alternativa1Criterio3 = TextEditingController();
    final note2Alternativa1Criterio3 = TextEditingController();
    final note3Alternativa1Criterio3 = TextEditingController();

    final note1Alternativa2Criterio3 = TextEditingController();
    final note2Alternativa2Criterio3 = TextEditingController();
    final note3Alternativa2Criterio3 = TextEditingController();

    final note1Alternativa3Criterio3 = TextEditingController();
    final note2Alternativa3Criterio3 = TextEditingController();
    final note3Alternativa3Criterio3 = TextEditingController();

    final note1Alternativa4Criterio3 = TextEditingController();
    final note2Alternativa4Criterio3 = TextEditingController();
    final note3Alternativa4Criterio3 = TextEditingController();

    final note1Alternativa5Criterio3 = TextEditingController();
    final note2Alternativa5Criterio3 = TextEditingController();
    final note3Alternativa5Criterio3 = TextEditingController();

    final note1Alternativa6Criterio3 = TextEditingController();
    final note2Alternativa6Criterio3 = TextEditingController();
    final note3Alternativa6Criterio3 = TextEditingController();

    int index = 0;
    Criteria listCriteria = Provider.of<Criteria>(context, listen: false);

    // Crie uma lista de controladores para as notas
    List<TextEditingController> noteControllers = [];

    // Inicialize os controladores com controladores vazios
    for (int i = 0; i < listCriteria.alternativeNames.length; i++) {
      noteControllers.add(TextEditingController());
    }

    List<GlobalKey<FormState>> noteFormKeys = List.generate(
      listCriteria.alternativeNames.length,
      (index) => GlobalKey<FormState>(),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            //width: double.infinity,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    5.0), // Ajuste o valor do raio conforme desejado
              ),
              scrollable: true,
              title: Text(
                'Cadastrar um novo Critério',
                style: AppTextStyles.body22,
                textAlign: TextAlign.center,
              ),
              content: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Form(
                  child: forms(nomeInput, pesoInput, note1Alternativa1Criterio1,
                      note2Alternativa1Criterio1, note3Alternativa1Criterio1,
                      note1Alternativa2Criterio1, note2Alternativa2Criterio1,
                      note3Alternativa2Criterio1, note1Alternativa3Criterio1,
                      note2Alternativa3Criterio1, note3Alternativa3Criterio1,
                      note1Alternativa4Criterio1, note2Alternativa4Criterio1,
                      note3Alternativa4Criterio1, note1Alternativa5Criterio1,
                      note2Alternativa5Criterio1, note3Alternativa5Criterio1,
                      note1Alternativa6Criterio1, note2Alternativa6Criterio1,
                      note3Alternativa6Criterio1, note1Alternativa1Criterio2,
                      note2Alternativa1Criterio2, note3Alternativa1Criterio2,
                      note1Alternativa2Criterio2, note2Alternativa2Criterio2,
                      note3Alternativa2Criterio2, note1Alternativa3Criterio2,
                      note2Alternativa3Criterio2, note3Alternativa3Criterio2,
                      note1Alternativa4Criterio2, note2Alternativa4Criterio2,
                      note3Alternativa4Criterio2, note1Alternativa5Criterio2,
                      note2Alternativa5Criterio2, note3Alternativa5Criterio2,
                      note1Alternativa6Criterio2, note2Alternativa6Criterio2,
                      note3Alternativa6Criterio2, note1Alternativa1Criterio3,
                      note2Alternativa1Criterio3, note3Alternativa1Criterio3,
                      note1Alternativa2Criterio3, note2Alternativa2Criterio3,
                      note3Alternativa2Criterio3, note1Alternativa3Criterio3,
                      note2Alternativa3Criterio3, note3Alternativa3Criterio3,
                      note1Alternativa4Criterio3, note2Alternativa4Criterio3,
                      note3Alternativa4Criterio3, note1Alternativa5Criterio3,
                      note2Alternativa5Criterio3, note3Alternativa5Criterio3,
                      note1Alternativa6Criterio3, note2Alternativa6Criterio3,
                      note3Alternativa6Criterio3, _keyN1A1C1, _keyN2A1C1,
                      _keyN3A1C1, _keyN1A2C1, _keyN2A2C1, _keyN3A2C1,
                      _keyN1A3C1, _keyN2A3C1, _keyN3A3C1, _keyN1A4C1,
                      _keyN2A4C1, _keyN3A4C1, _keyN1A5C1, _keyN2A5C1,
                      _keyN3A5C1, _keyN1A6C1, _keyN2A6C1, _keyN3A6C1,
                      _keyN1A1C2, _keyN2A1C2, _keyN3A1C2, _keyN1A2C2,
                      _keyN2A2C2, _keyN3A2C2, _keyN1A3C2, _keyN2A3C2,
                      _keyN3A3C2, _keyN1A4C2, _keyN2A4C2, _keyN3A4C2,
                      _keyN1A5C2, _keyN2A5C2, _keyN3A5C2, _keyN1A6C2,
                      _keyN2A6C2, _keyN3A6C2, _keyN1A1C3, _keyN2A1C3,
                      _keyN3A1C3, _keyN1A2C3, _keyN2A2C3, _keyN3A2C3,
                      _keyN1A3C3, _keyN2A3C3, _keyN3A3C3, _keyN1A4C3,
                      _keyN2A4C3, _keyN3A4C3, _keyN1A5C3, _keyN2A5C3,
                      _keyN3A5C3, _keyN1A6C3, _keyN2A6C3, _keyN3A6C3),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Consumer<Criteria>(
                  builder:
                      (BuildContext context, Criteria list, Widget? widget) {
                    return OutlinedButton(
                      onPressed: () async {
                        // Validação de dados
                        if (_keyNome.currentState!.validate() &&
                            _keyPeso.currentState!.validate()) {
                          late List<Alternative> alternatives = [];

                          bool notasValidas = true;
                          List<Map<String, String>> listMap = [];

                          notas.add(note1Alternativa1Criterio1.text);
                          notas.add(note2Alternativa1Criterio1.text);
                          notas.add(note3Alternativa1Criterio1.text);

                          notas.add(note1Alternativa2Criterio1.text);
                          notas.add(note2Alternativa2Criterio1.text);
                          notas.add(note3Alternativa2Criterio1.text);

                          notasMap.putIfAbsent("nota1", () => {
                            "notaMenor": notas[0],
                            "notaMédia": notas[1],
                            "notaMaior": notas[2],
                          });

                          notasMap.putIfAbsent("nota2", () => {
                            "notaMenor": notas[3],
                            "notaMédia": notas[4],
                            "notaMaior": notas[5],
                          });
                          notasMap["nota1"];

                          //listMap.add(notasMap.g);
                          //listMap.add(notasMap["nota2"]);


                          //listMap.add(notasMap.("nota1"));
                          //notasMap.putIfAbsent("notas", () => notas);
                          //notasMap.putIfAbsent("boletos", () => notas);

                          //print("Array 'Notas': $notas");
                          print("Map 'Notas': $listMap");
                          // for (int i = 0;
                          //     i < listCriteria.alternativeNames.length;
                          //     i++) {
                          //
                          //
                          //
                          //   if (nota.isNotEmpty) {
                          //     final notaValue = int.tryParse(nota);
                          //
                          //     if (notaValue != null &&
                          //         notaValue >= 1 &&
                          //         notaValue <= 10) {
                          //       alternatives.add(
                          //         Alternative(
                          //           name: listCriteria.alternativeNames[i],
                          //           note: notaValue,
                          //         ),
                          //       );
                          //     } else {
                          //       notasValidas = false;
                          //       break;
                          //     }
                          //   } else {
                          //     notasValidas = false;
                          //   }
                          // }

                          if (notasValidas) {
                            list.add(
                              nomeInput.text,
                              double.parse(pesoInput.text),
                              alternatives,
                            );

                            setState(() {
                              showInstruction = false;
                            });

                            Navigator.pop(context);
                            print("List: $listCriteria");
                          }
                        }
                        increment();
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                              color: AppColors
                                  .deepSkyBlue), // Define a cor da borda
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5.0), // Ajuste o valor do raio conforme desejado
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.deepSkyBlue),
                      ),
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  TextFormField formularioPadrao(label, controlador, chave, func) {
    return TextFormField(
      validator: func,
      key: chave,
      keyboardType: TextInputType.name,
      controller: controlador,
      decoration: InputDecoration(
        labelText: '${label}',
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 4),
              builder: (context, value, _) => SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 8,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column forms(nomeInput, pesoInput, note1Alternativa1Criterio1,
      note2Alternativa1Criterio1, note3Alternativa1Criterio1,
      note1Alternativa2Criterio1, note2Alternativa2Criterio1,
      note3Alternativa2Criterio1, note1Alternativa3Criterio1,
      note2Alternativa3Criterio1, note3Alternativa3Criterio1,
      note1Alternativa4Criterio1, note2Alternativa4Criterio1,
      note3Alternativa4Criterio1, note1Alternativa5Criterio1,
      note2Alternativa5Criterio1, note3Alternativa5Criterio1,
      note1Alternativa6Criterio1, note2Alternativa6Criterio1,
      note3Alternativa6Criterio1, note1Alternativa1Criterio2,
      note2Alternativa1Criterio2, note3Alternativa1Criterio2,
      note1Alternativa2Criterio2, note2Alternativa2Criterio2,
      note3Alternativa2Criterio2, note1Alternativa3Criterio2,
      note2Alternativa3Criterio2, note3Alternativa3Criterio2,
      note1Alternativa4Criterio2, note2Alternativa4Criterio2,
      note3Alternativa4Criterio2, note1Alternativa5Criterio2,
      note2Alternativa5Criterio2, note3Alternativa5Criterio2,
      note1Alternativa6Criterio2, note2Alternativa6Criterio2,
      note3Alternativa6Criterio2, note1Alternativa1Criterio3,
      note2Alternativa1Criterio3, note3Alternativa1Criterio3,
      note1Alternativa2Criterio3, note2Alternativa2Criterio3,
      note3Alternativa2Criterio3, note1Alternativa3Criterio3,
      note2Alternativa3Criterio3, note3Alternativa3Criterio3,
      note1Alternativa4Criterio3, note2Alternativa4Criterio3,
      note3Alternativa4Criterio3, note1Alternativa5Criterio3,
      note2Alternativa5Criterio3, note3Alternativa5Criterio3,
      note1Alternativa6Criterio3, note2Alternativa6Criterio3,
      note3Alternativa6Criterio3, _keyN1A1C1, _keyN2A1C1,
      _keyN3A1C1, _keyN1A2C1, _keyN2A2C1, _keyN3A2C1,
      _keyN1A3C1, _keyN2A3C1, _keyN3A3C1, _keyN1A4C1,
      _keyN2A4C1, _keyN3A4C1, _keyN1A5C1, _keyN2A5C1,
      _keyN3A5C1, _keyN1A6C1, _keyN2A6C1, _keyN3A6C1,
      _keyN1A1C2, _keyN2A1C2, _keyN3A1C2, _keyN1A2C2,
      _keyN2A2C2, _keyN3A2C2, _keyN1A3C2, _keyN2A3C2,
      _keyN3A3C2, _keyN1A4C2, _keyN2A4C2, _keyN3A4C2,
      _keyN1A5C2, _keyN2A5C2, _keyN3A5C2, _keyN1A6C2,
      _keyN2A6C2, _keyN3A6C2, _keyN1A1C3, _keyN2A1C3,
      _keyN3A1C3, _keyN1A2C3, _keyN2A2C3, _keyN3A2C3,
      _keyN1A3C3, _keyN2A3C3, _keyN3A3C3, _keyN1A4C3,
      _keyN2A4C3, _keyN3A4C3, _keyN1A5C3, _keyN2A5C3,
      _keyN3A5C3, _keyN1A6C3, _keyN2A6C3, _keyN3A6C3)

  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Text(
          "Insira os dados do critério",
          style: AppTextStyles.heading16,
        ),

        //TextFormField de 'Nome'
        formularioPadrao("Nome", nomeInput, _keyNome, EntradaVazia),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'Peso'
        formularioPadrao("Peso", pesoInput, _keyPeso, (val) => combine([
            () => EntradaVazia(val),
            () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 45,
        ),

        Text(
          "Insira as notas da alternativa 1",
          style: AppTextStyles.heading16,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Menor", note1Alternativa1Criterio1, _keyN1A1C1,
          (val) => combine([
            () => EntradaVazia(val),
            () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Média", note2Alternativa1Criterio1, _keyN2A1C1,
          (val) => combine([
            () => EntradaVazia(val),
            () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Maior", note3Alternativa1Criterio1, _keyN3A1C1,
          (val) => combine([
            () => EntradaVazia(val),
            () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 45,
        ),

        Text(
          "Insira as notas da alternativa 2",
          style: AppTextStyles.heading16,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Menor", note1Alternativa2Criterio1, _keyN1A2C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Média", note2Alternativa2Criterio1, _keyN2A2C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Maior", note3Alternativa2Criterio1, _keyN3A2C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 25,
        ),

        const SizedBox(
          height: 20,
        ),

        Text(
          "Insira as notas da alternativa 3",
          style: AppTextStyles.heading16,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Menor", note1Alternativa3Criterio1, _keyN1A3C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Média", note2Alternativa3Criterio1, _keyN2A3C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Maior", note3Alternativa3Criterio1, _keyN3A3C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 25,
        ),

        const SizedBox(
          height: 20,
        ),

        Text(
          "Insira as notas da alternativa 4",
          style: AppTextStyles.heading16,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Menor", note1Alternativa4Criterio1, _keyN1A4C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Média", note2Alternativa4Criterio1, _keyN2A4C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Maior", note3Alternativa4Criterio1, _keyN3A4C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 25,
        ),

        const SizedBox(
          height: 20,
        ),

        Text(
          "Insira as notas da alternativa 5",
          style: AppTextStyles.heading16,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Menor", note1Alternativa5Criterio1, _keyN1A5C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Média", note2Alternativa5Criterio1, _keyN2A5C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Maior", note3Alternativa5Criterio1, _keyN3A5C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 25,
        ),

        const SizedBox(
          height: 20,
        ),

        Text(
          "Insira as notas da alternativa 6",
          style: AppTextStyles.heading16,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Menor", note1Alternativa6Criterio1, _keyN1A6C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Média", note2Alternativa6Criterio1, _keyN2A6C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 20,
        ),

        //TextFormField de 'nota1'
        formularioPadrao("Nota Maior", note3Alternativa6Criterio1, _keyN3A6C1,
              (val) => combine([
                () => EntradaVazia(val),
                () => EntradaForaDoRange(val),
          ]),
        ),

        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
