mixin ValidationsMixin{
  String? EntradaVazia(String? value){
    if (value!.isEmpty) return "Campo vazio!";
    return null;
  }

  String? EntradaForaDoRange(String? value){
    int numero = int.parse(value!);
    if (numero < 1 || numero > 10){
      return "Insira uma nota de 1 a 10";
    }
    else {
      return null;
    }
  }

  String? combine(List<String? Function()> validators){
    for (final func in validators){
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}