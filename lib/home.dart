import 'package:flutter/material.dart';
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
  final _name_controller = TextEditingController();
  final _note_controller = TextEditingController();

  void Salvar() {
    String name = _name_controller.text;
    int note = int.parse(_note_controller.text);

    // Consumer<Criteria>(
    //     builder: (BuildContext context, Criteria list, Widget? widget) {
    //       return 0;
    //     });

    List<int> lista = [];
    lista.add(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alternativas",
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
                TextFormField(
                  onEditingComplete: Salvar,
                  controller: _note_controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Nota",
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
                    "Nome: ${list.alternativeNames.length}, \n"
                        "Peso: ${list.alternativeNames.toString()} \n"
                        //"Nome: ${list.criteria.take(1)}"
                ),
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
                            builder: (context) => Output()));
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
    TextEditingController nomeInput = TextEditingController();
    TextEditingController pesoInput = TextEditingController();
    int index = 0;
    Criteria listCriteria = Provider.of<Criteria>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            //width: double.infinity,
            child: AlertDialog(
              scrollable: true,
              title: const Text('Cadastrar um novo Critério'),
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
                      const Padding(padding: EdgeInsets.all(5)),

                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: pesoInput,
                        decoration: const InputDecoration(
                          labelText: 'Peso',
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      SizedBox(height: 30,),
                      Text("${listCriteria.alternativeNames[0]}"),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nomeInput,
                        decoration: const InputDecoration(
                          labelText: 'Nota',
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      SizedBox(height: 30,),
                      Text("${listCriteria.alternativeNames[1]}"),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nomeInput,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(5)),

                      const Padding(padding: EdgeInsets.all(5)),
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
                              nomeInput.text, double.parse(pesoInput.text), []);
                          for (int i = 0; i < list.criteria.length; i++)
                            print(list.criteria[i]);
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
