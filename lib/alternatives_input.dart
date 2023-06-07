import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
import 'package:hash_test/home.dart';
import 'package:provider/provider.dart';

import 'basic_templates/appColors.dart';
import 'components/criteria.dart';

class InputAlternatives extends StatefulWidget {
  const InputAlternatives({Key? key}) : super(key: key);

  @override
  State<InputAlternatives> createState() => _InputAlternativesState();
}

class _InputAlternativesState extends State<InputAlternatives> {
  final _formKey = GlobalKey<FormFieldState>();

  int i = 0;

  void increment() {
    i++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Criteria>(
        builder: (BuildContext context, Criteria list, Widget? widget) {
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
                          title: const Text("Alternativas"),
                          content: const Text(
                              "Alternativa é toda opção de compra que você "
                              "tem.\n"
                              "Exemplo: ao comprar um computador, você tem "
                              "3 opções, um da marca Acer, um da marca "
                              "Dell e outro da marca Apple. Essas são as "
                              "alterntivas de compra."),
                          actions: [
                            OutlinedButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.info_outline_rounded))
              ],
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
              title: Text(
                'Alternativas',
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
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.alternativeNames.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColors.deepSkyBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: Text(
                                list.alternativeNames[index],
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20.0, left: 8, right: 8),
                    child: ElevatedButton(
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
                          MaterialPageRoute(builder: (context) => const Home()),
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          createInputAlt(context);
          increment();
        },
        tooltip: 'Add Criterion',
        child: const Icon(Icons.add),
      ),
    );
  }

  void createInputAlt(context) {
    TextEditingController nomeInput = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            scrollable: true,
            title: const Text('Cadastrar uma nova Alternativa'),
            content: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      validator: (String? valor) {
                        if (valor!.isEmpty) {
                          return "Não pode adicionar Alternativa vazia";
                        } else {
                          return null;
                        }
                      },
                      key: _formKey,
                      keyboardType: TextInputType.name,
                      controller: nomeInput,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
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
                builder: (BuildContext context, Criteria list, Widget? widget) {
                  return OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                            color: Colors.blue), // Define a cor da borda
                      ),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      overlayColor: MaterialStateProperty.all<Color>(
                        Colors.blue.withOpacity(0.2),
                      ),
                    ),
                    child: const Text(
                      "Salvar",
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        list.addName(nomeInput.text);
                        Navigator.pop(context);
                        print(list.alternativeNames);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
