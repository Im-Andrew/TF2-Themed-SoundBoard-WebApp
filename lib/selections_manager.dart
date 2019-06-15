import "dart:async";
import "dart:html";
import "globals.dart";
import "character_data.dart" as CD;
import "selection_data.dart";

class SelectionsManager{
  List<Element> _selections;
  bool _loaded;
  bool _listening;
  Function _listener;
  Element _hook;

  SelectionsManager(this._hook):_selections = [],_loaded = false, _listening = false;

  Future<Null> open( Function listener ) async {
    if( !_loaded ){
      _loaded = true;
      for( int i = 0; i < Characters.values.length - 1; i ++ ){
        CD.CharacterData charData = initConfig[Characters.values[i]];
        String loadName = charData.name;
        AudioElement audio = await new AudioElement("./audio/class_selection/${loadName}.wav")
          ..onLoadedData.first;
        ImageElement img = await new ImageElement(src:"./images/class_selection/${loadName}_icon.png")
          ..onLoad.first;
        SelectionData sel = new SelectionData( charData.name, img, audio, i);
        // _selections.add( sel.getElement() );
        Element el = sel.getElement();
        _hook.append( el );
        _attatchListener(el, Characters.values[i] );
      } 
    }
    _listening = true;
    _listener = listener;
  }

  void _attatchListener(Element el, Characters char ){
    el.onClick.listen( (MouseEvent ev ){
      AudioElement audio = el.querySelector("audio");
      audio.play();
      if( _listening ){ _listener( char ); }
    });
  }

  void close(){
    _listening = false;
    _listener = null;
  }

}