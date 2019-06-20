class QuestionItem {
  QuestionItem(this.id, this.value, this.checkState);
  final int id;
  final String value;
  bool checkState;
  bool isCorrect = false;
}