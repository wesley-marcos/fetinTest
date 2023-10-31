import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hash_test/components/appBar.dart';
import 'package:hash_test/components/buttonProximo.dart';
import 'package:hash_test/components/floatActionButton.dart';
import 'package:hash_test/components/showDialog.dart';
import 'package:hash_test/screens/alternatives/containerView.dart';
import 'package:hash_test/screens/criterios/home.dart';
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
                  wButtonProximo(
                    context,
                    "Aviso",
                    "Adicione pelo menos 2 alternativas antes "
                        "de "
                        "prosseguir.",
                    const Home(),
                    false,
                    () {
                      // Validar se há pelo menos 2 alternativas
                      if (Provider.of<Criteria>(context, listen: false)
                              .alternativeNames
                              .length <
                          2) {
                        wShowDialog(
                          context,
                          "Aviso",
                          "Adicione pelo menos 2 alternativas antes "
                              "de "
                              "prosseguir.",
                        );
                      } else {
                        // Navegar para a próxima tela
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: wFloatActionButton(
          context,
          "Limite atingido",
          "Você atingiu o limite de 5 alternativas.",
          numberOfAlternatives,
          createInputAlt,
          increment),
    );
  }

  void createInputAlt(context) {
    TextEditingController nomeInput = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  5.0), // Ajuste o valor do raio conforme desejado
            ),
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
                            color:
                                AppColors.deepSkyBlue), // Define a cor da borda
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.deepSkyBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5.0), // Ajuste o valor do raio conforme desejado
                        ),
                      ),
                    ),
                    child: const Text(
                      "Salvar",
                      style: TextStyle(color: Colors.black),
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
