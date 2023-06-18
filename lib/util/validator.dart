const emptyMsg = 'You must enter at least one character.';

String? textEmptyValidator(String? value) {
  if (value != null) {
    return value.isEmpty ? emptyMsg : null;
  }
  return null;
}