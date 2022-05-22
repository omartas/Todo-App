import 'package:mobil_odev_1/models/category.dart';
import 'package:mobil_odev_1/repositories/repository.dart';

class CategoryService {
  Repository? _repository;
  CategoryService(){
    _repository = Repository();
  }
  saveCategory(Category category ) async{
    return await _repository?.insertData("categories", category.categoryMap());
  }
  readCategories()async{
    return await _repository?.readData("categories");
  }
  readCategoryId(categoryId)async{
    return await _repository?.readDataByID("categories",categoryId);
  }
  updateCategory(Category category)async{
    return await _repository?.updateData("categories",category.categoryMap());
  }
  deleteCategory(categoryId)async{
    return await _repository?.deleteData("categories",categoryId);
  }
  deleteTablee()async{
    return await _repository?.deleteTable();
  }
}
