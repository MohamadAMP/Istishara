import 'package:istishara/Client/Categories/category.dart';

class Utils {
  static List<Categories> getMockedCategories() {
    return [
      Categories(name: "Architecture", imagename: "architecture"),

      Categories(name: "Interior Design", imagename: "interior"),

      // Categories(name: "Civil Engineering",
      // imagename: "civil"),

      Categories(name: "Electrical Engineering", imagename: "electrical"),

      Categories(name: "Mechanical Engineering", imagename: 'mechanical'),
    ];
  }
}
