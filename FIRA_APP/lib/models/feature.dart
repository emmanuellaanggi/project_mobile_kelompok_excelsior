import 'package:fira/utils/utils.dart';

class Feature {
  int id;
  String name;
  String photo;
  String location = 'Seattle, USA.';
  String gender;
  int age;

  Feature(this.id, this.name, this.photo, this.gender, this.age);
}


// Names generated at http://random-name-generator.info/
final List<Feature> features = [
  Feature(1, 'Lapor', AvailableImages.man1['assetPath'], 'M', 27),
  Feature(2, 'Pemadam', AvailableImages.woman1['assetPath'], 'F', 24),
  Feature(3, 'Artikel', AvailableImages.man2['assetPath'], 'M', 28),
];