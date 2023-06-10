import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
import 'package:hash_test/components/alternative.dart';
import 'package:hash_test/components/criteria.dart';
import 'package:hash_test/components/criterion.dart';
import 'package:provider/provider.dart';
import '../basic_templates/appColors.dart';
import 'output.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Definindo as 'Keys' utilizadas
  final _keyNome = GlobalKey<FormFieldState>();
  final _keyPeso = GlobalKey<FormFieldState>();
  final _keyNota1 = GlobalKey<FormFieldState>();
  final _keyNota2 = GlobalKey<FormFieldState>();
  final _keyNota3 = GlobalKey<FormFieldState>();

  @override
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
                    child: Text("Critérios", style: AppTextStyles.title3),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        "Aqui você entra com os "
                        "critérios importantes na hora "
                        "de tomar sua decisão.",
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
          'Criterios',
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
            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: list.criteria.length,
                    itemBuilder: (context, index) {
                      final color = index % 2 == 0
                          ? AppColors.deepSkyBlue.withOpacity(0.5)
                          : Colors.white.withOpacity(0.8);
                      final criterion = list.criteria[index];
                      //final alternative = list.alternatives[index];
                      return ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.center,
                        title: Text(
                          "Critério: ${criterion.criterionName}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        children: [
                          Text(
                            "Peso: ${criterion.weight}",
                            style: AppTextStyles.heading15Nbold,
                          ),
                          Text(
                            "Alternativa: ${criterion.alternatives[0].name}",
                            style: AppTextStyles.heading15Nbold,
                          ),
                          Text(
                            "Nota: ${criterion.alternatives[0].note}",
                            style: AppTextStyles.heading15Nbold,
                          ),
                          Text(
                            "Alternativa: ${criterion.alternatives[1].name}",
                            style: AppTextStyles.heading15Nbold,
                          ),
                          Text(
                            "Nota: ${criterion.alternatives[1].note}",
                            style: AppTextStyles.heading15Nbold,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, left: 20, right: 50),
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
                      // Validar se há pelo menos 2 alternativas
                      if (Provider.of<Criteria>(context, listen: false)
                              .criteria
                              .length <
                          2) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("Aviso", style: AppTextStyles.title3),
                            ),
                            content: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  "Adicione pelo menos 2 critérios antes de "
                                  "prosseguir.",
                                  textAlign: TextAlign.justify,
                                  style: AppTextStyles.heading16NBold),
                            ),
                            actions: [
                              OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(color: Colors.blue),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                ),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Navegar para a próxima tela
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Output()),
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Próximo",
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
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.blue,
        onPressed: () {
          createCriteria(context);
        },
        tooltip: 'Add Criterion',
        shape: RoundedRectangleBorder(
          // Define a forma do botão
          borderRadius:
              BorderRadius.circular(35.0), // Define o raio do canto do botão
          side: const BorderSide(color: Colors.black12), // Define o contorno
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void createCriteria(context) {
    // Definindo os controladores dos TextFormFields
    final nomeInput = TextEditingController();
    final pesoInput = TextEditingController();
    final note1Input = TextEditingController();
    final note2Input = TextEditingController();
    final note3Input = TextEditingController();

    int index = 0;
    Criteria listCriteria = Provider.of<Criteria>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            //width: double.infinity,
            child: AlertDialog(
              scrollable: true,
              title: Text(
                'Cadastrar um novo Critério',
                style: AppTextStyles.body20,
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
                      TextFormField(
                        validator: (String? valor) {
                          if (valor!.isEmpty) {
                            return "Nome Vazio. Favor, preencher!";
                          } else {
                            return null;
                          }
                        },
                        key: _keyNome,
                        keyboardType: TextInputType.name,
                        controller: nomeInput,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      TextFormField(
                        validator: (String? valor) {
                          if (valor!.isEmpty) {
                            return "Peso Vazio. Favor, preencher!";
                          } else {
                            return null;
                          }
                        },
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alternativa: ${listCriteria.alternativeNames[0]}",
                            style: AppTextStyles.heading16NBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (String? valor) {
                              if (valor!.isEmpty) {
                                return "Nota Vazia. Favor, preencher!";
                              } else {
                                return null;
                              }
                            },
                            key: _keyNota1,
                            keyboardType: TextInputType.number,
                            controller: note1Input,
                            decoration: const InputDecoration(
                              labelText: 'Nota',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Alternativa: ${listCriteria.alternativeNames[1]}",
                            style: AppTextStyles.heading16NBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (String? valor) {
                              if (valor!.isEmpty) {
                                return "Nota Vazia. Favor, preencher!";
                              } else {
                                return null;
                              }
                            },
                            key: _keyNota2,
                            keyboardType: TextInputType.number,
                            controller: note2Input,
                            decoration: const InputDecoration(
                              labelText: 'Nota',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Consumer<Criteria>(
                  builder:
                      (BuildContext context, Criteria list, Widget? widget) {
                    return TextButton(
                        child: const Text("Salvar"),
                        onPressed: () async {
                          if (_keyPeso.currentState!.validate() &
                              _keyNome.currentState!.validate() &
                              _keyNota1.currentState!.validate() &
                              _keyNota2.currentState!.validate()) {
                            list.add(
                                nomeInput.text, double.parse(pesoInput.text), [
                              Alternative(
                                  name: list.alternativeNames[0],
                                  note: int.parse(note1Input.text)),
                              Alternative(
                                  name: list.alternativeNames[1],
                                  note: int.parse(note2Input.text))
                              //listCriteria.alternatives,
                            ]);

                            Navigator.pop(context);
                          }
                        });
                  },
                ),
                TextButton(
                    child: const Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }
}
