import 'package:fittrix_task/util/capitalize_helper.dart';

extension EnumByName<T extends Enum> on Iterable<T> {
  T? tryByName(dynamic name) {
    if(name is String) {
      try {
        return byName(name);
      } catch(_) {}
    }

    return null;
  }
}

const underBar = '_';

extension EnumDeleteUnderBar<T extends Enum> on Iterable<T> {
  String getCapitalizeName(T value) {
    final name = value.name;
    if (name.contains(underBar)) {
      List<String> splitNames = name.split(underBar);
      StringBuffer buffer = StringBuffer();
      for (final data in splitNames) {
        if (data != splitNames.last) {
          buffer.writeAll({data, ' '});
        } else {
          buffer.write(data);
        }
      }
      return buffer.toString();
    }
    return value.name.capitalize();
  }
}