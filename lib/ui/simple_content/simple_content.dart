class SimpleContent {

  String contentId  = "";
  String contentString  = "";
  int contentType  = 0;
  String correctOptions = "";

  SimpleContent(this.contentId, this.contentString, this.contentType,
      this.correctOptions);

  static const int header = 0;
  static const int content = 1;
  static const int bullets = 2;
  static const int code = 3;
  static const int image = 4;
  static const int mcq = 5;
  static const int rearrange = 6;
  static const int fillBlanks = 7;
  static const int codeMcq = 8; //Contains code in Question
  static const int syntaxLearn = 9;


}