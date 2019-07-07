abstract class BaseInteractionListener<T> {
  void onSuccess(T item);
  void onCancel(String error);
}
