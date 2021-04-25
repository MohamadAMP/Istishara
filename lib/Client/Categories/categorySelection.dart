import 'package:flutter/material.dart';
import 'package:istishara/Classes/category.dart';
import 'package:istishara/Client/Categories/questionsArchitecture.dart';
import 'package:istishara/Client/Categories/questionsECE.dart';
import 'package:istishara/Client/Categories/questionsID.dart';
import 'package:istishara/Client/Categories/questionsMech.dart';
import 'package:istishara/Client/Categories/utils.dart';
import 'package:istishara/Services/Authentication/auth.dart';
import 'package:istishara/Services/Database/firestore.dart';
import 'package:istishara/Services/Login/login.dart';
import 'package:istishara/Widgets/categorycard.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../aboutUsClient.dart';
import '../baseClientHomepage.dart';
import 'questionsArchitecture.dart';
import 'questionsCivil.dart';

// ignore: must_be_immutable
class CategoryListPage extends StatelessWidget {
  var user;
  CategoryListPage(this.user);
  var image = Image.asset("assets/Istishara_logo.png");
  List<Categories> categories = Utils.getMockedCategories();

  @override
  Widget build(BuildContext context) {
    void _showRatingDialog() {
      final _dialog = RatingDialog(
        // your app's name?
        title: 'Istishara',
        // encourage your user to leave a high rating?
        message: 'Tap a star to set your rating.',
        // your app's logo?
        image: Image.asset("assets/istisharaphoto.jpeg"),
        submitButton: 'Submit',
        onSubmitted: (response) {
          addAppRating(this.user.uid, response.comment, response.rating);
        },
      );
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => _dialog,
      );
    }

    return Scaffold(
        drawer: Container(
          width: 300,
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Image(
                    image: Image.asset("assets/Istishara_logo.png").image,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, size: 30),
                  title: Text('Home',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BaseClientHomepage(this.user)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info, size: 30),
                  title: Text('About Us',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.star, size: 30),
                  title: Text('Rate Us',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  onTap: () {
                    _showRatingDialog();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, size: 30),
                  title: Text('Log Out',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  onTap: () {
                    signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ),
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
