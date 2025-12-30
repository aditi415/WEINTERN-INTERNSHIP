class CalculatorLogic {
  static String calculate(String n1, String n2, String operator) {
    if (n1.isEmpty || n2.isEmpty) {
      return "Please enter both numbers";
    }

    double num1 = double.tryParse(n1) ?? 0;
    double num2 = double.tryParse(n2) ?? 0;
    double result;

    switch (operator) {
      case "+":
        result = num1 + num2;
        break;
      case "-":
        result = num1 - num2;
        break;
      case "×":
        result = num1 * num2;
        break;
      case "÷":
        if (num2 == 0) {
          return "Cannot divide by zero";
        }
        result = num1 / num2;
        break;
      default:
        return "Invalid Operation";
    }

    return "Result: $result";
  }
}
