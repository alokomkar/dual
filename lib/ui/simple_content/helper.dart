import 'package:dual_mode/ui/simple_content/simple_content.dart';

List<SimpleContent> getOOFirstContent()  {

  List<SimpleContent>  simpleContentList = List<SimpleContent>();
  simpleContentList.add(SimpleContent("", "What Is an Object?", SimpleContent.header, "" ));
  simpleContentList.add(SimpleContent("",
      "It is a basic unit of Object Oriented Programming and represents the real life entities.  A typical Java program creates many objects, which as you know, interact by invoking methods. An object consists of :", SimpleContent.content, "" ));
  simpleContentList.add(SimpleContent("",
      "State : It is represented by attributes of an object. It also reflects the properties of an object.\n" +
          "Behavior : It is represented by methods of an object. It also reflects the response of an object with other objects.\n" +
          "Identity : It gives a unique name to an object and enables one object to interact with other objects."
      , SimpleContent.bullets, ""));

  simpleContentList.add(SimpleContent("",
      "https://www.guru99.com/images/java/052016_0704_ObjectsandC6.jpg",
      SimpleContent.image, ""));

  simpleContentList.add(SimpleContent("",
      "Objects correspond to things found in the real world. For example, a graphics program may have objects such as “circle”, “square”, “menu”. An online shopping system might have objects such as “shopping cart”, “customer”, and “product”.",
      SimpleContent.content, ""));

  simpleContentList.add(SimpleContent("",
      "/*Here's a sample class Car\n" +
          "with attributes : car type and wheel count*/\n" +
          "class Car {\n" +
          " private String carType;\n" +
          " private int wheelCount;\n" +
          "}",
      SimpleContent.code, ""));
  simpleContentList.add(SimpleContent("",
      "/*Here's a sample class Car\n" +
          "with attributes : car type and wheel count*/\n" +
          "class Car {\n" +
          " private String carType;\n" +
          " private int wheelCount;\n" +
          "}",
      SimpleContent.mcq, ""));
  simpleContentList.add(SimpleContent("",
      "/*Here's a sample class Car\n" +
          "with attributes : car type and wheel count*/\n" +
          "class Car {\n" +
          " private String carType;\n" +
          " private int wheelCount;\n" +
          "}",
      SimpleContent.codeMcq, ""));
  simpleContentList.add(SimpleContent("",
      "/*Here's a sample class Car\n" +
          "with attributes : car type and wheel count*/\n" +
          "class Car {\n" +
          " private String carType;\n" +
          " private int wheelCount;\n" +
          "}",
      SimpleContent.drag_and_drop, ""));
  return simpleContentList;

}