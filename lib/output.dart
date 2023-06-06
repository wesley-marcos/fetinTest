import 'package:flutter/material.dart';
import 'package:hash_test/data/criterion_inherited.dart';
import 'package:hash_test/home.dart';
import 'package:flutter/material.dart';
import 'package:hash_test/components/criteria.dart';
import 'package:hash_test/components/criterion.dart';
import 'package:provider/provider.dart';
import 'basic_templates/appColors.dart';
import 'basic_templates/appColors.dart';

class Output extends StatefulWidget {
  const Output({Key? key}) : super(key: key);

  //final BuildContext CriterionCont;

  @override
  State<Output> createState() => _OutputState();
}

class _OutputState extends State<Output> {
  @override
  final _name_controller = TextEditingController();
  final _note_controller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saída",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: AppColors.dodgerBlue,
      ),
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
            padding: EdgeInsets.only(top: 30, left: 30, right: 30),
            alignment: Alignment.center,
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                  onEditingComplete: () {
                    String name = _name_controller.text;
                    list.add(name, 0.2, []);
                    for (int i = 0; i < list.criteria.length; i++) {
                      print(list.criteria[i].criterionName);
                    }
                  },
                  controller: _name_controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nome da Alternativa",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 20,
                  height: 100,
                ),
                const SizedBox(
                  width: 20,
                  height: 100,
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Output(),
                //       ),
                //     );
                //   },
                //   //onPressed: Salvar,
                //   child: const Text(
                //     "Próximo",
                //     style: TextStyle(
                //         fontSize: 22,
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                // ListView.builder(
                //   itemCount: list.criteria.length,
                //   itemBuilder: (context, index) {
                //     return Dismissible(
                //       key: UniqueKey(),
                //       background: Container(color: Colors.red),
                //       child: ListTile(
                //         leading: Icon(Icons.email),
                //         title: Text(list.criteria[index].criterionName +
                //             ' (' +
                //             list.criteria[index].weight.toString() +
                //             ')'),
                //         iconColor: Colors.indigo,
                //       ),
                //       onDismissed: (direction) {
                //         list.remove(index);
                //       },
                //     );
                //   },
                // ),
                Text("Tamanho do array: ${list.criteria.length}"),
                Text(
                    "Nome: ${list.criteria.first.criterionName}, \n"
                        "Peso: ${list.criteria.first.weight} \n"
                        "Nome: ${list.criteria.take(1)}"
                ),

                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //       primary: Colors.blue,
                //       //splashFactory: NoSplash.splashFactory,
                //       elevation: 10,
                //       fixedSize: Size(100, 50),
                //       side: BorderSide(color: Colors.black12),
                //       shape: BeveledRectangleBorder(
                //           borderRadius: BorderRadius.circular(10)
                //         //RoundedRectangleBorder
                //       )),
                //   onPressed: Salvar,
                //   child: const Text(
                //     "Próximo",
                //     style: TextStyle(
                //         fontSize: 22,
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
