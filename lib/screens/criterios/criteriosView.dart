import 'package:flutter/material.dart';
import 'package:hash_test/basic_templates/app_text_styles.dart';
import 'package:hash_test/components/alternative.dart';

Container wCriteriosView(
    color, criterion, labelTitle, weight, alternative, note) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 5.0,
          spreadRadius: 2.0,
          offset: const Offset(
              0, 3), // ajuste a posição vertical da sombra conforme necessário
        ),
      ],
    ),
    child: ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      expandedAlignment: Alignment.center,
      title: Text(
        "$labelTitle: ${criterion.criterionName}",
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
              "        $weight: ",
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
                Text("$alternative", style: AppTextStyles.body20),
                for (Alternative alternative in criterion.alternatives)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child:
                        Text("${alternative.name}", style: AppTextStyles.text1),
                  ),
              ],
            ),
            Column(
              children: [
                Text("$note", style: AppTextStyles.body20),
                for (Alternative alternative in criterion.alternatives)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child:
                        Text("${alternative.note}", style: AppTextStyles.text1),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
