import 'package:flutter/material.dart';
import 'package:mobil_odev_1/screen/categories_screen.dart';
import 'package:mobil_odev_1/screen/home_screen.dart';
import 'package:mobil_odev_1/tododone.dart';
import '../models/category.dart';
import '../services/category_services.dart';


class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  var _categoryService = CategoryService();
  List<Category> _categoryList = List<Category>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }
  getAllCategories() async {
    var categories = await _categoryService.readCategories();

    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category["name"];
        _categoryList.add(categoryModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://www.gravatar.com/avatar/8517497a7f008f1f0debf093fecebf2b?s=64&d=identicon&r=PG&f=1"),
              ),
              accountName: Text("Ömer Faruk Taş"),
              accountEmail: Text("omerftas0@gmail.com"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text("Categories "),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Categories()));
              },
            ),
            Divider(color: Colors.black,height: 0.8,),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _categoryList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 8, left: 16),
                  child: Card(
                    elevation:3,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              TextButton(onPressed: (){
                                Navigator.push(context,  new MaterialPageRoute(builder: (context)=>ToDoDone(category: _categoryList[index].name.toString(),)));
                              }, child: Text(_categoryList[index].name.toString())),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

          ],
        ),

      ),
    );
  }
}
