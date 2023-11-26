import 'book_model.dart';

List<Book> books = [];
List<Map> categories = [
  {'name': "Flutter", 'pdf': "https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf"},
  {'name': "Angular", 'pdf': "https://riptutorial.com/Download/angular.pdf"},
  {'name': "Python", 'pdf': "https://bugs.python.org/file47781/Tutorial_EDIT.pdf"},
  {'name': "Java", 'pdf': "https://www.tutorialspoint.com/java/java_tutorial.pdf"},
  {'name': ".Net", 'pdf': "https://www.tutorialspoint.com/asp.net/asp.net_tutorial.pdf"},
  {'name': "MongoDB", 'pdf': "https://www.tutorialspoint.com/mongodb/mongodb_tutorial.pdf"},
  {'name': "SQL", 'pdf': "https://www.hcoe.edu.np/uploads/attachments/r96oytechsacgzi4.pdf"},
  {'name': "HTML", 'pdf': "https://www.tutorialspoint.com/html/html_tutorial.pdf"},
  {'name': "GIT", 'pdf': "https://indico.cern.ch/event/724719/contributions/2981043/attachments/1638054/2754736/Git_tutorial.pdf"},
];
List authors = [
  "Simon Long",
  "Joyce Kay Avila",
  "Wes McKinney",
  "Cathy Chan",
  "Kyran Dale",
  "Jeremey Arnold",
  "Klaus lg Berger",
  "Yevgenly Brikman",
  "Richard Rose",
  "Jake VanderPlas",
  "Simon Monk",
  "Michael Washington",
  "Penny De Byl",
  "Mounir Maaref",
  "Ivo BalBaert",
  "Maaike Van Putten",
  "Abdul Tanner",
  "Simon Amey",
  "Alexander Shuiskov",
  "Christine W. Park & John Alderman"
];
List pdfs = [
  "https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf",
  "https://riptutorial.com/Download/angular.pdf",
  "https://bugs.python.org/file47781/Tutorial_EDIT.pdf",
  "https://www.tutorialspoint.com/java/java_tutorial.pdf",
  "https://www.tutorialspoint.com/asp.net/asp.net_tutorial.pdf",
  "https://www.tutorialspoint.com/mongodb/mongodb_tutorial.pdf",
  "https://www.hcoe.edu.np/uploads/attachments/r96oytechsacgzi4.pdf",
  "https://www.tutorialspoint.com/html/html_tutorial.pdf",
  "https://indico.cern.ch/event/724719/contributions/2981043/attachments/1638054/2754736/Git_tutorial.pdf",
  "https://pcpl21.org/wp-content/uploads/2020/09/How-To-Use-Google-Docs.pdf",
  "https://www.techaheadcorp.com/wp-content/uploads/2019/10/mobile-application-development-guide-pdf.pdf",
  "https://www.tutorialspoint.com/computer_programming/computer_programming_tutorial.pdf",
  "https://store.samhsa.gov/sites/default/files/d7/priv/sma16-4958.pdf",
  "https://www.tutorialspoint.com/software_engineering/software_engineering_tutorial.pdf"
];
var screenWidth = 0.0;
var screenHeight = 0.0;
Book selectedBook = Book();
DateTime? currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    return Future.value(false);
  }
  return Future.value(true);
}
