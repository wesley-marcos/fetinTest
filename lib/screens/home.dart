import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
import 'package:hash_test/components/alternative.dart';
import 'package:hash_test/components/criteria.dart';
import 'package:hash_test/utils/validations_mixin.dart';
import 'package:provider/provider.dart';
import '../basic_templates/appColors.dart';
import 'output.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with ValidationsMixin{
  // Definindo as 'Keys' utilizadas
  final _keyNome = GlobalKey<FormFieldState>();
  final _keyPeso = GlobalKey<FormFieldState>();

  bool _isLoading = false;

  int numberOfCriteria = 0;

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
                        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                        expandedAlignment: Alignment.center,
                        title: Text(
                          "Critério: ${criterion.criterionName}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                        children: [
                          Row(
                            children: [
                              Text(
                                "        Peso: ",
                                style: AppTextStyles.body20,
                              ),
                              Text(
                                "${criterion.weight}",
                                style: AppTextStyles.text1,
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text("Alternativa",
                                      style: AppTextStyles.body20),
                                  for (Alternative alternative
                                      in criterion.alternatives)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Text("${alternative.name}",
                                          style: AppTextStyles.text1),
                                    ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Nota", style: AppTextStyles.body20),
                                  for (Alternative alternative
                                      in criterion.alternatives)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Text("${alternative.note}",
                                          style: AppTextStyles.text1),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, left: 20, right: 50),
                  child: _isLoading // Verificar se o loading está ativo
                      ? const CircularProgressIndicator() // Exibir o loading
                      : ElevatedButton(
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
                                    .criteria
                                    .length <
                                2) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Aviso",
                                        style: AppTextStyles.title3),
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
                                        side: MaterialStateProperty.all<
                                            BorderSide>(
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

                              // Converter list para JSON
                              // final jsonData = jsonEncode(Provider
                              //     .of<Criteria>(context, listen: false).criteria);
                              // print(jsonData);

                              _showLoadingDialog(
                                  context); // Exibir o showDialog do loading

                              // Atraso de 1 segundo
                              Future.delayed(const Duration(seconds: 4), () {
                                Navigator.pop(
                                    context); // Fechar o showDialog do loading

                                // Navegar para a próxima tela
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Output()),
                                );
                              });
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
          if (numberOfCriteria < 5) {
            createCriteria(context);
            numberOfCriteria++; // Incrementa o contador de alternativas
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
                    "Você atingiu o limite de 5 critérios.",
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
        tooltip: 'Add Criterion',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
          side: const BorderSide(color: Colors.black12),
        ),
        child: const Icon(Icons.add),
      ),


      // FloatingActionButton(
      //   elevation: 10,
      //   backgroundColor: Colors.blue,
      //   onPressed: () {
      //     createCriteria(context);
      //   },
      //   tooltip: 'Add Criterion',
      //   shape: RoundedRectangleBorder(
      //     // Define a forma do botão
      //     borderRadius:
      //         BorderRadius.circular(35.0), // Define o raio do canto do botão
      //     side: const BorderSide(color: Colors.black12), // Define o contorno
      //   ),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  void createCriteria(context) {
    // Definindo os controladores dos TextFormFields
    final nomeInput = TextEditingController();
    final pesoInput = TextEditingController();
    final nota0Input = TextEditingController();
    final nota1Input = TextEditingController();
    final nota2Input = TextEditingController();
    final nota3Input = TextEditingController();
    final nota4Input = TextEditingController();
    final globalInput = GlobalKey();

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
                                if (index < listCriteria.alternativeNames.length - 1)
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
                  child: const Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Consumer<Criteria>(
                  builder:
                      (BuildContext context, Criteria list, Widget? widget) {
                    return OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                              color: Colors.blue), // Define a cor da borda
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {

                        String validateNota(String value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          final nota = int.tryParse(value);
                          if (nota == null || nota < 1 || nota > 10) {
                            return 'A nota deve estar entre 1 e 10';
                          }
                          return ''; // A entrada é válida
                        }

                        if (_keyNome.currentState!.validate() && _keyPeso.currentState!.validate()) {
                          late List<Alternative> alternatives = [];

                          bool notasValidas = true;

                          for (int i = 0; i < listCriteria.alternativeNames.length; i++) {

                            final nota = noteControllers[i].text;

                            if (nota.isNotEmpty) {

                              final notaValue = int.tryParse(nota);

                              if (notaValue != null && notaValue >= 1 && notaValue <= 10) {

                                alternatives.add(
                                  Alternative(
                                    name: listCriteria.alternativeNames[i],
                                    note: notaValue,
                                  ),
                                );

                              }

                              else {
                                notasValidas = false;
                                break;
                              }
                            }

                            else{
                              notasValidas = false;
                            }
                          }

                          if (notasValidas) {
                            list.add(
                              nomeInput.text,
                              double.parse(pesoInput.text),
                              alternatives,
                            );

                            Navigator.pop(context);
                            print("List: $listCriteria");
                          }
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  // void createCriteria(BuildContext context) {
  //   // Definindo os controladores dos TextFormFields
  //   final nomeInput = TextEditingController();
  //   final pesoInput = TextEditingController();
  //
  //   int index = 0;
  //   Criteria listCriteria = Provider.of<Criteria>(context, listen: false);
  //   GlobalKey<FormState> _keyNome = GlobalKey<FormState>();
  //
  //
  //   // Crie uma lista de controladores para as notas
  //   List<TextEditingController> noteControllers = [];
  //
  //   // Inicialize os controladores com controladores vazios
  //   for (int i = 0; i < listCriteria.alternativeNames.length; i++) {
  //     noteControllers.add(TextEditingController());
  //   }
  //
  //   // Crie uma lista de chaves globais para os campos de notas
  //   List<GlobalKey<FormState>> noteFormKeys = List.generate(
  //     listCriteria.alternativeNames.length,
  //         (index) => GlobalKey<FormState>(),
  //   );
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         //width: double.infinity,
  //         child: AlertDialog(
  //           scrollable: true,
  //           title: Text(
  //             'Cadastrar um novo Critério',
  //             style: AppTextStyles.body22,
  //             textAlign: TextAlign.center,
  //           ),
  //           content: Padding(
  //             padding: const EdgeInsets.all(2.0),
  //             child: Form(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     "Insira os dados do critério",
  //                     style: AppTextStyles.heading16,
  //                   ),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   TextFormField(
  //                     validator: (String? valor) {
  //                       if (valor!.isEmpty) {
  //                         return "Nome Vazio. Favor, preencher!";
  //                       }
  //                       return null;
  //                     },
  //                     key: _keyNome,
  //                     keyboardType: TextInputType.name,
  //                     controller: nomeInput,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Nome',
  //                     ),
  //                   ),
  //                   const Padding(padding: EdgeInsets.all(5)),
  //                   TextFormField(
  //                     validator: (String? valor) {
  //                       if (valor!.isEmpty) {
  //                         return "Peso Vazio. Favor, preencher!";
  //                       } else {
  //                         return null;
  //                       }
  //                     },
  //                     key: _keyPeso,
  //                     keyboardType: TextInputType.number,
  //                     controller: pesoInput,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Peso',
  //                     ),
  //                   ),
  //                   const Padding(padding: EdgeInsets.all(5)),
  //                   const SizedBox(
  //                     height: 20,
  //                   ),
  //                   Text(
  //                     "Insira as notas",
  //                     style: AppTextStyles.heading16,
  //                   ),
  //                   const SizedBox(
  //                     height: 25,
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: List.generate(
  //                       listCriteria.alternativeNames.length,
  //                           (index) {
  //                         return Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               "Alternativa: ${listCriteria.alternativeNames[index]}",
  //                               style: AppTextStyles.heading16NBold,
  //                             ),
  //                             const SizedBox(
  //                               height: 10,
  //                             ),
  //                             TextFormField(
  //                               key: noteFormKeys[index], // Use a chave global
  //                               keyboardType: TextInputType.number,
  //                               controller: noteControllers[index],
  //                               decoration: const InputDecoration(
  //                                 labelText: 'Nota',
  //                               ),
  //                               validator: (String? value) {
  //                                 if (value == null || value.isEmpty) {
  //                                   return "Nota vazia. Favor, preencher!";
  //                                 }
  //                                 int? intValue = int.tryParse(value);
  //                                 if (intValue == null ||
  //                                     intValue < 0 ||
  //                                     intValue > 10) {
  //                                   return "Nota inválida. Insira um valor entre 0 e 10.";
  //                                 }
  //                                 return null; // A nota é válida
  //                               },
  //                             ),
  //                             if (index < listCriteria.alternativeNames.length - 1)
  //                               const SizedBox(
  //                                 height: 20,
  //                               ),
  //                           ],
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //               child: const Text("Cancelar"),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             Consumer<Criteria>(
  //               builder: (BuildContext context, Criteria list, Widget? widget) {
  //                 return OutlinedButton(
  //                   style: ButtonStyle(
  //                     side: MaterialStateProperty.all<BorderSide>(
  //                       const BorderSide(
  //                           color: Colors.blue), // Define a cor da borda
  //                     ),
  //                     backgroundColor:
  //                     MaterialStateProperty.all<Color>(Colors.blue),
  //                   ),
  //                   child: const Text(
  //                     "Salvar",
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   onPressed: () async {
  //                     bool allNotesAreValid = true;
  //
  //                     for (final formKey in noteFormKeys) {
  //                       if (!formKey.currentState!.validate()) {
  //                         allNotesAreValid = false;
  //                       }
  //                     }
  //
  //                     if (allNotesAreValid &&
  //                         _keyPeso.currentState!.validate() &&
  //                         _keyNome.currentState!.validate()) {
  //                       late List<Alternative> alternatives = [];
  //
  //                       for (int i = 0; i < listCriteria.alternativeNames.length; i++) {
  //                         if (noteControllers[i].text.isNotEmpty) {
  //                           alternatives.add(
  //                             Alternative(
  //                               name: listCriteria.alternativeNames[i],
  //                               note: int.parse(noteControllers[i].text),
  //                             ),
  //                           );
  //                         }
  //                       }
  //
  //                       list.add(
  //                         nomeInput.text,
  //                         double.parse(pesoInput.text),
  //                         alternatives,
  //                       );
  //
  //                       Navigator.pop(context);
  //                       print("List: $listCriteria");
  //                     }
  //                   },
  //                 );
  //               },
  //             ),
  //
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

}

bool _validateNotas(List<TextEditingController> noteControllers) {
  for (int i = 0; i < noteControllers.length; i++) {
    final nota = noteControllers[i].text;
    if (nota.isNotEmpty) {
      final notaValue = int.tryParse(nota);
      if (notaValue == null || notaValue < 1 || notaValue > 10) {
        return false; // Uma nota inválida foi encontrada
      }
    }
  }
  return true; // Todas as notas são válidas
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
