class QuestionItem {

  QuestionItem(this.id, this.value, this.checkState){
    isQuestion = this.value.isEmpty;
  }

  final int id;
  String value;
  bool checkState;
  bool isCorrect = false;
  bool isQuestion = false;
  bool isDraggable = false;

  @override
  String toString() {
    return '$value\n';
  }


}