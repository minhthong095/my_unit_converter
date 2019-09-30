class Lodash {
  static T find<T>(List<T> list, bool Function(T) model) {
    final index = list.indexWhere(model);
    return list.elementAt(index);
  }
}
