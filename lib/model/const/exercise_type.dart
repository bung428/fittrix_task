// ignore_for_file: constant_identifier_names

enum ExType {
  lunge('Lunge', 'assets/images/lunge.png'),
  squats('Squats', 'assets/images/squats.png'),
  push_up('Push-up', 'assets/images/push_up.png'),
  leg_raise('Leg raise', 'assets/images/leg_raise.png')
  ;

  final String typeName;
  final String image;

  const ExType(this.typeName, this.image);
}