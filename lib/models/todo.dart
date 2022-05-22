class Todo{
  int? id;
  String? title;
  String? description;
  String? category;
  String? tododate;

  todoMap(){
    var mapping = Map<String,dynamic>();
    mapping["id"] = id;
    mapping["title"] = title;
    mapping["description"] = description;
    mapping["category"] = category;
    mapping["tododate"] = tododate;
    return mapping;
  }
}