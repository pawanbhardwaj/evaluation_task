class TimeHelper {
  static String getTextForGreeting(DateTime time) {
    if (time.hour >= 0 && time.hour < 6) return "Good Night";
    if (time.hour >= 6 && time.hour < 12) return "Good Morning";
    if (time.hour >= 12 && time.hour < 18) return "Good Afternoon";
    return "Good Evening";
  }
}
