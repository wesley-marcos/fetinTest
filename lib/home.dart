import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
import 'package:hash_test/components/alternative.dart';
import 'package:hash_test/components/criteria.dart';
import 'package:hash_test/components/criterion.dart';
import 'package:provider/provider.dart';
import 'basic_templates/appColors.dart';
import 'data/criterion_inherited.dart';
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

  // void Salvar() {
  //   String name = _name_controller.text;
  //   int note = int.parse(_note_controller.text);
  //
  //   // Consumer<Criteria>(
  //   //     builder: (BuildContext context, Criteria list, Widget? widget) {
  //   //       return 0;
  //   //     });
  //
  //   List<int> lista = [];
  //   lista.add(note);
  // }

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
                  title: const Text("Critérios"),
                  content: const Text("Aqui você entra com o número de "
                      "critérios que você leva em consideração na hora "
                      "de tomar sua decisão."),
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
            padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
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
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(color: Colors.red),
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                                offset: const Offset(0,
                                    3), // ajuste a posição vertical da sombra conforme necessário
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              "Critério: ${list.criteria[index]}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          list.remove(index);
                        },
                      );
                    },
                  ),
                ),
                Text("Tamanho do array: ${list.criteria.length}"),
                Text("Nome: ${list.alternativeNames.length}, \n"
                    "Peso: ${list.alternativeNames.toString()} \n"
                    //"Nome: ${list.criteria.take(1)}"
                    ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 10,
                    fixedSize: const Size(230, 50),
                    side: const BorderSide(color: Colors.black12),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Output()),
                    );
                  },
                  child: const Text(
                    "Próximo",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          createCriteria(context);
        },
        tooltip: 'Add Criterion',
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
                style: AppTextStyles.bodybold18Black,
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
                      for (final alternativeName
                          in listCriteria.alternativeNames)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Alternativa: $alternativeName"),
                            TextFormField(
                              validator: (String? valor) {
                                if (valor!.isEmpty) {
                                  return "Nota Vazia. Favor, preencher!";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(),
                              decoration: const InputDecoration(
                                labelText: 'Nota',
                              ),
                              onChanged: (value) {
                                listCriteria.updateAlternativeNote(
                                  alternativeName,
                                  int.parse(value),
                                );
                              },
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
                          list.add(
                              nomeInput.text, double.parse(pesoInput.text), [
                            Alternative(
                                name: list.alternativeNames[0],
                                note: int.parse(note1Input.text)),
                            Alternative(
                                name: list.alternativeNames[1],
                                note: int.parse(note2Input.text))
                          ]);
                          for (int i = 0; i < list.criteria.length; i++) {
                            print(listCriteria.criteria[i]);
                          }
                          Navigator.pop(context);
                          // if (true) {
                          //
                          // }
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
