import 'globals.dart';
/// Very basic container class
class CharacterData{
  String name;
  List<String> quotes;
  int images;
  Characters character;
  final List<int> hashes;
  CharacterData( this.name, this.quotes, this.images, this.character ):hashes=[]{
    for( String q in quotes ){
      hashes.add( "${character.index}${q}".hashCode );
    }
  }
}