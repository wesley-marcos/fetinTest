import 'package:flutter/material.dart';
import 'package:hash_test/components/alternative.dart';
import 'package:hash_test/components/alternatives.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Criteria>(
        builder: (BuildContext context, Criteria list, Widget? widget) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.DeepSkyBlue,
                    AppColors.LightSkyBlue,
                    AppColors.lightBlue,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
            child: ListView(
              children: [
                SizedBox(height: 20,),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      //splashFactory: NoSplash.splashFactory,
                      elevation: 10,
                      fixedSize: Size(100, 50),
                      side: BorderSide(color: Colors.black12),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        //RoundedRectangleBorder
                      )),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home()));
                  },

                  child: const Text(
                    "Próximo",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          createInputAlt(context);
        },
        tooltip: 'Add Criterion',
        child: const Icon(Icons.add),
      ),
    );
  }

  void createInputAlt(context) {
    TextEditingController nomeInput = TextEditingController();

    //Criteria listCriteria = Provider.of<Criteria>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            //width: double.infinity,
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
                Consumer<Criteria>(
                  builder:
                      (BuildContext context, Criteria list, Widget? widget) {
                    return TextButton(
                        child: const Text("Salvar"),
                        onPressed: () async {
                          list.addName(nomeInput.text);
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
