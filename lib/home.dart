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
      appBar: AppBar(
        title: const Text(
          "Critérios",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: AppColors.dodgerBlue,
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
                      Text("Alternativa: ${listCriteria.alternativeNames[0]}"),
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
                      Text("Alternativa: ${listCriteria.alternativeNames[1]}"),
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
