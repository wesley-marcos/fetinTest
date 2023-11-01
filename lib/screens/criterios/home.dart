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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Insira os dados do critério",
                        style: AppTextStyles.heading16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //TextFormField de 'Nome'
                      TextFormField(
                        validator: EntradaVazia,
                        key: _keyNome,
                        keyboardType: TextInputType.name,
                        controller: nomeInput,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                      ),

                      const Padding(padding: EdgeInsets.all(5)),

                      //TextFormField de 'Peso'
                      TextFormField(
                        validator: (val) => combine([
                          () => EntradaVazia(val),
                          () => EntradaForaDoRange(val),
                        ]),
                        key: _keyPeso,
                        keyboardType: TextInputType.number,
                        controller: pesoInput,
                        decoration: const InputDecoration(
                          labelText: 'Peso',
                        ),
                      ),

                      const Padding(padding: EdgeInsets.all(5)),

                      const SizedBox(
                        height: 20,
                      ),

                      Text(
                        "Insira as notas",
                        style: AppTextStyles.heading16,
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //Coluna com a entrada das notas
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          listCriteria.alternativeNames.length,
                          (index) {
                            final noteController = noteControllers[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Alternativa: ${listCriteria.alternativeNames[index]}",
                                  style: AppTextStyles.heading16NBold,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: noteController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nota',
                                  ),
                                  key: noteFormKeys[index],
                                  validator: (val) => combine([
                                    () => EntradaVazia(val),
                                    () => EntradaForaDoRange(val),
                                  ]),
                                ),
                                if (index <
                                    listCriteria.alternativeNames.length - 1)
                                  const SizedBox(
                                    height: 20,
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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

                          for (int i = 0;
                              i < listCriteria.alternativeNames.length;
                              i++) {
                            final nota = noteControllers[i].text;

                            if (nota.isNotEmpty) {
                              final notaValue = int.tryParse(nota);

                              if (notaValue != null &&
                                  notaValue >= 1 &&
                                  notaValue <= 10) {
                                alternatives.add(
                                  Alternative(
                                    name: listCriteria.alternativeNames[i],
                                    note: notaValue,
                                  ),
                                );
                              } else {
                                notasValidas = false;
                                break;
                              }
                            } else {
                              notasValidas = false;
                            }
                          }

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
