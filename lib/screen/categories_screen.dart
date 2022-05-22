import 'package:flutter/material.dart';
import 'package:mobil_odev_1/services/category_services.dart';

import '../helpers/drawer_navigation.dart';
import '../models/category.dart';
import 'home_screen.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var category;
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

  var _category = Category();
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
        categoryModel.id = category["id"];
        categoryModel.name = category["name"];
        categoryModel.description = category["description"];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryId(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]["name"] ?? "No name";
      _editCategoryDescriptionController.text =
          category[0]["description"] ?? "No description";
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  //_category.id = _categoryList.length+1;
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;
                  var result = await _categoryService.saveCategory(_category);
                  print(_category.id);
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Categories()), (Route<dynamic>route) => false);
                  },
                child: Text("Save"),
              ),
            ],
            title: Text("Categories Form"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: "category",
                      labelText: "Category",
                    ),
                    controller: _categoryNameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "description",
                      labelText: "Description",
                    ),
                    controller: _categoryDescriptionController,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    _category.id = category[0]["id"];
                    _category.name = _categoryNameController.text;
                    _category.description = _categoryDescriptionController.text;

                    //_categoryService.saveCategory(_category);
                    var result =
                        await _categoryService.updateCategory(_category);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Categories()), (Route<dynamic>route) => false);

                  },
                  child: Text("Update")),
            ],
            title: Text("Categories Form"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Write a category",
                      labelText: "Category",
                    ),
                    controller: _categoryNameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Write a description",
                      labelText: "Description",
                    ),
                    controller: _categoryDescriptionController,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    var result =
                        await _categoryService.deleteCategory(categoryId);
                    //var result1 = await _categoryService.deleteTablee();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Categories()), (Route<dynamic>route) => false);

                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
            title: Text("Silmek istediğine emin misin ?"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen()));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8, left: 16),
            child: Card(
              elevation: 8,
              child: ListTile(
                leading: IconButton(
                  onPressed: () {
                    _editCategory(context, _categoryList[index].id);
                  },
                  icon: Icon(Icons.edit),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(_categoryList[index].name.toString()),
                        Text(_categoryList[index].description.toString()),
                      ],
                    ),
                    Text(_categoryList[index].id.toString()),
                    IconButton(
                      onPressed: () {
                        _deleteFormDialog(context, _categoryList[index].id);

                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
