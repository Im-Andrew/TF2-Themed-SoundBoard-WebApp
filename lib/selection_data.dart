import "dart:html";
import "globals.dart";
class SelectionData{
  ImageElement _img;
  AudioElement _snd;
  String _name;
  int _index;

  SelectionData(this._name, this._img, this._snd, this._index);

  Element getElement(){
    // Generate a tile through the grid template
    Element el = selectTemplate.generate({
      "name": _name,
      "index":_index.toString(),
    });

    // Add the custom elements in their appropriate places
    el.querySelector(".img").append( _img.clone(false)  );
    el.querySelector(".audio").append( _snd.clone(false) );
    return el;
  }
}