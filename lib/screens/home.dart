import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
import 'package:hash_test/components/alternative.dart';
import 'package:hash_test/components/criteria.dart';
import 'package:hash_test/utils/validations_mixin.dart';
import 'package:provider/provider.dart';
import '../basic_templates/appColors.dart';
import 'output.dart';

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

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
    );
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

    List<GlobalKey<FormState>> minorNoteFormKeys = List.generate(
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
                            final minorNoteController = noteControllers[index];

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
                                  controller: minorNoteController,
                                  decoration: const InputDecoration(
                                    labelText: 'Nota',
                                  ),
                                  key: minorNoteFormKeys[index],
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
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        // Validação de dados
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

                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                              color: Colors.blue), // Define a cor da borda
                        ),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
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
