import 'globals.dart';
import 'dart:math';
import 'dart:html';
import 'character_data.dart' as CD;
import 'tile_data.dart';
import 'dart:async';

Map<Characters,TileManager> _tileManagers = {};

class TileManager{
  String name;                      // character name/url
  Characters char;
  int _sprites;                     /// number of portaits
  List<String> _quotes;             // character quotes (ordered*)
  Map<int,TileData> _characterTiles;   /// Actual (loaded) [TileData]'s
  List<ImageElement> _images;       // (loaded) Portrait images 

  static final Random random = new Random();  // Share the same random block with all TileManager's
  bool _loaded = false;
  bool _loadedSprites = false;
  bool _isFavoriteManager = false;
  Map<int,bool> _loadedElements;

  static TileManager getManager(Characters character)=>_tileManagers[character];

  // For handling displaying tiles that are loaded asynchronously..
  StreamController<TileData> _tileController;
  Stream<TileData> _broadcaster;
  StreamSubscription<TileData> _tileSubscription;

  factory TileManager.fromCD(CD.CharacterData cd) => 
    getManager(cd.character) ?? new TileManager._fromCD(cd);
  
  /// Create a Tile Manager using a character data 
  TileManager._fromCD( CD.CharacterData cd ): char = cd.character, 
    name = cd.name, _quotes = cd.quotes,
    _loadedElements = {},
    _sprites = cd.images, _tileController = new StreamController(),
    _characterTiles = {}, _images = []{
    _broadcaster = _tileController.stream.asBroadcastStream();

    _tileManagers[char] = this;
  } 

  factory TileManager.favoritesManager()=>
    getManager(Characters.FAVORITES)?? new TileManager._favoritesManager();

  TileManager._favoritesManager(){
    _loadedElements = {};
    _characterTiles = favoriteSounds;
    name = "favorites";
    _tileController = new StreamController();
    _broadcaster = _tileController.stream.asBroadcastStream();
    _isFavoriteManager = true;

    _tileManagers[char] = this;
  }

  /// Blank incrementer
  // TileManager( this.name, this._quotes, this._sprites );

  Future<Null> _loadSprites() async {
    if( !_loadedSprites ){
      _loadedSprites = true;
      // syncrhnously Load each portrait image of this class
      for( int i = 0; i < _sprites; i ++  ){
        ImageElement image = new ImageElement(src:"./images/${name}/portrait_${i}.png");
        await image.onLoad;
        _images.add( image );
      }
    }
  }

  Future<TileData> _loadTile(int i,[bool ignoreStream=false]) {
    // Return existing tile
    if( _loadedElements[i] ){
      return new Future.value(_characterTiles[i]);
    }

    _loadedElements[i] = true;
    // Try to load the tile
    return new Future((){
      AudioElement audio = new AudioElement("./audio/${name}/audio_${i}.wav");
      return audio.onLoadedData.first.then((_){
        // Create a tile and add to our tile list
        var portrait = _images[random.nextInt(_images.length-1)];
        var color = colors[random.nextInt(colors.length-1)];
        TileData tile = new TileData( _quotes[i], portrait,  audio, color, i, char);
        // Notify stream listeners if our state is still correct 
        if(!ignoreStream){ _tileController.add( tile );} 
        _characterTiles[i] = tile;
        return tile;
      });
    });
  }

  void _loadFavorites(){
    if( !_loaded ){
      _loaded = true;
      for( CD.CharacterData data in initConfig.values ){
        print("...${data.character}");
        for( int i = 0; i < data.hashes.length; i++ ){
          int hash = data.hashes[i];
          if( favoriteSounds.containsKey(hash) ){continue;}
          if( window.localStorage.containsKey(hash.toString()) ){
            TileManager tm = getManager(data.character);
            tm.getTile(data.quotes[i]).then((TileData tile){
              _tileController.add( tile ); 
            });
          }
        }
      }
    }
  }

  // Loads all tile elements...
  Future<Null> load() async {
    if( _isFavoriteManager ){
      _loadFavorites();
    }
    else if( !_loaded ){
      // Don't load anymore
      _loaded = true;
      await _loadSprites();

      // Asynchronously load and emit on our Stream loaded tiles
      for( int i = 0; i < _quotes.length; i ++ ){
        if( !_loadedElements[i] ){
          _loadTile(i);
        }
      }
    }
  }

  Future<TileData> getTile( String quote ) async{
    await _loadSprites();
    int index = _quotes.indexOf(quote);
    if( index != -1 ){ return _loadTile(index, true); }
    else{ return new Future.value(null);}
  }

  Future<Null> getTiles(Function callback ) async {
    // Just clean up the stream to discard duplicates
    for( int index in _characterTiles.keys ){
      _tileController.add( _characterTiles[index] );
    }
    load();
    _tileSubscription = _broadcaster.listen(callback);
  }

  /// Use to stop events
  void close(){
    if( _tileSubscription != null ){
      _tileSubscription.cancel();
      _tileController = new StreamController();
      _broadcaster = _tileController.stream.asBroadcastStream();
      print("closed");
    }
  }
}
