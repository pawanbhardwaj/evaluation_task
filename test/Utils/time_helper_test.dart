import 'package:evaluation_task/Utils/time_helper.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Greeting text should come as", () {
    test("Good Night", () {
      DateTime test = DateTime(2021, 7, 23, 5);
      String greetingText = TimeHelper.getTextForGreeting(test);

      expect(greetingText, "Good Night");
    });
    test("Good Morning", () {
      DateTime test = DateTime(2021, 7, 23, 7);
      String greetingText = TimeHelper.getTextForGreeting(test);

      expect(greetingText, "Good Morning");
    });
    test("Good Afternoon", () {
      DateTime test = DateTime(2021, 7, 23, 17);
      String greetingText = TimeHelper.getTextForGreeting(test);

      expect(greetingText, "Good Afternoon");
    });
    test("Good Night", () {
      DateTime test = DateTime(2021, 7, 23, 19);
      String greetingText = TimeHelper.getTextForGreeting(test);

      expect(greetingText, "Good Evening");
    });
    test("Good Morning", () {
      DateTime test = DateTime(2021, 7, 23, 8);
      String greetingText = TimeHelper.getTextForGreeting(test);

      expect(greetingText, "Good Morning");
    });
  });
}
