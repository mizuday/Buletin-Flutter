extension ImageStringExtension on String{
  String get svg => 'assets/svg/$this.svg';
  String get png => 'assets/png/$this.png';
  String get jpg => 'assets/jpg/$this.jpg';
}