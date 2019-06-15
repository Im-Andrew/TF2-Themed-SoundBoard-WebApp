import "globals.dart";
import 'dart:html';
import 'tile_manager.dart';
import 'dart:async';
import 'tile_data.dart';

class GridController{
  Element _gridContainer;
  Characters _charState = null; // Init state
  Map<Characters,TileManager> _tileManager;
  TileManager _activeManager;
  static const Duration _longPressDuration = const Duration(milliseconds: 500);

  List<StreamSubscription<MouseEvent>> _listeners;  // for clearin hanging listeners

  /**
   * Requires an [Element] to hook on to for updating the grid. 
   */
  GridController( this._gridContainer ){
    _tileManager = {};
    _listeners = [];
    for( Characters char in Characters.values ){
      // We want favorites out of this.
      if( char == Characters.FAVORITES ){ 
        _tileManager[char] = new TileManager.favoritesManager();
        continue; 
      }
      _tileManager[ char ] = new TileManager.fromCD(initConfig[char]);
    }
  }

  /**
   * Changes the current grid state and loads correct data..
   * 
   * closes previous stream
   * 
   * clears children
   * 
   * changes state
   * 
   * loads the tiles for the current class
   */
  void changeState(Characters character){
    if( character != _charState ){
      if( _activeManager != null ){
        _activeManager.close();
      }
      _clearTiles();
      _clearListeners();
      _charState = character;
      _tileManager[ character ].getTiles(_addTile);
      _activeManager = _tileManager[ character ];
    }
  }

  /// Clear..
  void _clearTiles()=>_gridContainer.children.clear();
  void _clearListeners(){
    for( StreamSubscription<MouseEvent> sub in _listeners ){
      sub.cancel();
    }
    _listeners.clear();
  }

  /// Handler for recieving tiles.
  void _addTile( TileData tileData ){
    Element gridTile = tileData.getElement();
    // Add listeners 
    _addTileListeners(gridTile, tileData);

    // Append to grid
    _gridContainer.append(gridTile);

    // Sort children
    List<Element> children = _gridContainer.children.toList(); 
    children.sort( ( el1, el2  )=>
      int.parse(el1.dataset["index"]) 
      - int.parse(el2.dataset["index"]));
    _clearTiles();
    for( Element el in children ){
      _gridContainer.append(el);
    }
  }

  void _addTileListeners( Element gridTile, TileData tileData){
    // Play sound on regular click
    AudioElement audio = gridTile.querySelector("audio");
    Timer favTimer = null;
    bool longPressed = false;

    var listenerA = gridTile.onMouseDown.listen( (MouseEvent e){
      if( favTimer != null ){ favTimer.cancel(); }
      favTimer = new Timer( _longPressDuration, (){
        if( this._charState != Characters.FAVORITES ){
          tileData.favorited = !tileData.favorited;
          playFavoritedSound(tileData.favorited);
          tileData.updateElementBorder(gridTile);
          longPressed = true;
        }
      });
    } );

    var listenerB = gridTile.onClick.asBroadcastStream().listen((MouseEvent e ) {
      // We favorited this track, so don't play this sound.
      if( longPressed ){ longPressed = false; }
      else{
        // Run the track and cancel timeout
        audio.currentTime = 0;
        audio.play();
        favTimer.cancel();
      }
      e.preventDefault();
    });

     _listeners.add(listenerA);
     _listeners.add(listenerB);
  }
}
