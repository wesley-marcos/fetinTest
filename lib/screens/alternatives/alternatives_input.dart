import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
import 'package:hash_test/components/appBar.dart';
import 'package:hash_test/screens/alternatives/containerView.dart';
import 'package:hash_test/screens/home.dart';
import 'package:provider/provider.dart';

import '../../basic_templates/appColors.dart';
import '../../components/criteria.dart';

class InputAlternatives extends StatefulWidget {
  const InputAlternatives({Key? key}) : super(key: key);

  @override
  State<InputAlternatives> createState() => _InputAlternativesState();
}

class _InputAlternativesState extends State<InputAlternatives> {
  final _formKey = GlobalKey<FormFieldState>();

  int numberOfAlternatives = 0;

  int i = 0;

  void increment() {
    i++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: wAppbar(
          context,
          "Alternativas",
          "Alternativa é toda opção de escolha que você "
              "tem.\n\n"
              "Exemplo\nAo comprar um computador, você tem "
              "as três alternativas seguintes: um da marca Acer, "
              "um da marca "
              "Dell e outro da marca Apple."),
      body: Consumer<Criteria>(
        builder: (BuildContext context, Criteria list, Widget? widget) {
          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.alternativeNames.length,
                      itemBuilder: (context, index) {
                        final color = index % 2 == 0
                            ? AppColors.lightSkyBlue.withOpacity(0.5)
                            : Colors.white.withOpacity(0.5);
                        final alternativeName = list.alternativeNames[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(color: Colors.red),
                          child: wContainerView(color, index, alternativeName),
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
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 20, right: 50),
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
                        // Validar se há pelo menos 2 alternativas
                        if (Provider.of<Criteria>(context, listen: false)
                                .alternativeNames
                                .length <
                            2) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                    Text("Aviso", style: AppTextStyles.title3),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                    "Adicione pelo menos 2 alternativas antes "
                                    "de "
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
                                builder: (context) => const Home()),
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
            ),
          );
        },
      ),
      //floatingActionButton:
      // FloatingActionButton(
      //   elevation: 10,
      //   backgroundColor: Colors.blue,
      //   onPressed: () {
      //     createInputAlt(context);
      //     increment();
      //   },
      //   tooltip: 'Add Alternative',
      //   shape: RoundedRectangleBorder(
      //     // Define a forma do botão
      //     borderRadius:
      //         BorderRadius.circular(35.0), // Define o raio do canto do botão
      //     side: const BorderSide(color: Colors.black12), // Define o contorno
      //   ),
      //   child: const Icon(Icons.add),
      // ),

      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.blue,
        onPressed: () {
          if (numberOfAlternatives < 5) {
            createInputAlt(context);
            increment();
            numberOfAlternatives++; // Incrementa o contador de alternativas
          } else {
            // Mostra um aviso quando o limite é atingido
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Limite atingido", style: AppTextStyles.title3),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Você atingiu o limite de 5 alternativas.",
                    textAlign: TextAlign.justify,
                    style: AppTextStyles.heading16NBold,
                  ),
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.blue),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        tooltip: 'Add Alternative',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
          side: const BorderSide(color: Colors.black12),
        ),
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    child: const Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white),
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
