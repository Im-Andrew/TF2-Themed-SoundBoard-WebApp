import "dart:html";
import "globals.dart";


Map<int, TileData> _loadedTiles = {};

/**
 * Basic container which holds information about specific tiles..
 */
class TileData{
  String _quote;        // associated quote
  Characters _myCharacter;
  ImageElement _image;  // cached img
  AudioElement _sound;  // cached snd
  String _color;        // Saved associated css color
  int index;
  bool _faved;
  static Storage _localStorage = window.localStorage;
  int _hash; 
  
  bool get favorited => _faved;
  void set favorited(bool val){
    if( val == _faved ){ return; }
    _faved = val;
    if( _faved ){
      _faveStore();
    }
    else{
      _faveUnstore();
    }
  }

  TileData( this._quote, this._image, this._sound, this._color, this.index, this._myCharacter){
    _loadIsFaved();
  }

  void _loadIsFaved(){
    _hash = "${_myCharacter.index}${this._quote}".hashCode;
    favorited = _localStorage.containsKey(_hash.toString());
  }
  void _faveUnstore(){
    _localStorage.remove(_hash.toString());
    favoriteSounds.remove(_hash);
  }
  void _faveStore(){
    _localStorage[_hash.toString()] = "1";
    favoriteSounds[_hash] = this;
  }

  Element getElement(){
    // Generate a tile through the grid template
    Element el = tileTemplate.generate({
      "quote":_quote,
      //"index":index.toString(),
      //"color":_color
    });

    // Add the custom elements in their appropriate places
    el.style.backgroundColor = _color;
    el.dataset["index"] = index.toString();
    el.querySelector(".img").append( _image.clone(false)  );
    el.querySelector(".audio").append( _sound.clone(false) );
    updateElementBorder(el);
    return el;
  }

  void updateElementBorder(Element el){
    if( _faved ){
      el.style.borderColor = _color;
    }
    else{
      el.style.removeProperty("border-color");
    }
  }
}