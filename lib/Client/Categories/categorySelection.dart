import 'package:flutter/material.dart';
import 'package:istishara/Classes/category.dart';
import 'package:istishara/Client/Categories/questionsArchitecture.dart';
import 'package:istishara/Client/Categories/questionsECE.dart';
import 'package:istishara/Client/Categories/questionsID.dart';
import 'package:istishara/Client/Categories/questionsMech.dart';
import 'package:istishara/Client/Categories/utils.dart';
import 'package:istishara/Widgets/categorycard.dart';
import 'questionsArchitecture.dart';
import 'questionsCivil.dart';

// ignore: must_be_immutable
class CategoryListPage extends StatelessWidget {
  var user;
  CategoryListPage(this.user);

  List<Categories> categories = Utils.getMockedCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(title: Text('Home')),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text('Select a Category',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (BuildContext ctx, int index) {
                  var category = categories[index];
                  if (category.name == "Architecture") {
                    return CategoryCard(
                        category: categories[index],
                        onCardClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QuestionsArchitecture(this.user)));
                        });
                  }
                  if (category.name == "Interior Design") {
                    return CategoryCard(
                        category: categories[index],
                        onCardClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QuestionsID(this.user)));
                        });
                  }
                  if (category.name == "Electrical Engineering") {
                    return CategoryCard(
                        category: categories[index],
                        onCardClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QuestionsECE(this.user)));
                        });
                  }
                  if (category.name == "Mechanical Engineering") {
                    return CategoryCard(
                        category: categories[index],
                        onCardClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QuestionsMech(this.user)));
                        });
                  }
                  if (category.name == "Civil Engineering") {
                    return CategoryCard(
                        category: categories[index],
                        onCardClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QuestionsCivil(this.user)));
                        });
                  } else {
                    return SizedBox(height: 0);
                  }
                },
              ))
            ],
          ),
        ));
  }
}
