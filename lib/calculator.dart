
import 'package:flutter/material.dart';

double convertGradeToGPA(double grade) {
  if (grade >= 90) {
    return 4.0;
  } else if (grade >= 85) {
    return 3.7;
  } else if (grade >= 80) {
    return 3.3;
  } else if (grade >= 70) {
    return 3.0;
  } else if (grade >= 65) {
    return 2.7;
  } else if (grade >= 60) {
    return 2.3;
  } else if (grade >= 50) {
    return 2.0;
  } else if (grade >= 45) {
    return 1.7;
  } else if (grade >= 40) {
    return 1.3;
  } else if (grade >= 30) {
    return 1.0;
  } else {
    return 0.0;
  }
}

double? calculateGPA(
    List<TextEditingController> gradeControllers,
    List<int> creditSelections,
    ) {
  double totalPoints = 0;
  double totalCredits = 0;

  for (int i = 0; i < gradeControllers.length; i++) {
    double grade = double.tryParse(gradeControllers[i].text) ?? 0;
    int credit = creditSelections[i];

    if (grade >= 0 && grade <= 100 && (credit == 1 || credit == 3)) {
      double gpaGrade = convertGradeToGPA(grade);
      totalPoints += gpaGrade * credit;
      totalCredits += credit;
    } else {
      return null;
    }
  }

  if (totalCredits > 0) {
    return totalPoints / totalCredits;
  } else {
    return null;
  }
}
