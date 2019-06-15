import "grid_controller.dart";
import "selections_manager.dart";
import "globals.dart";
import "dart:html";

class AppController{
  int _viewState = 0;
  Element _viewActive;
  GridController _gridController;
  SelectionsManager _selectionManager;
  List<Element> _views;

  AppController(){
    Element gridEl = document.getElementById("grid");
    Element selectEl = document.getElementById("selection");
    _gridController = new GridController( gridEl );
    _selectionManager = new SelectionsManager( selectEl );
    _views= [ gridEl, selectEl];
    _viewActive = _views[0];
    attachListeners();
  }

  void attachListeners(){
    document.getElementById("favorites").onClick.listen((MouseEvent e){
      setView(0);
      _gridController.changeState(Characters.FAVORITES);
    });

    document.getElementById("open-selection").onClick.listen((MouseEvent e){
      int toView = 1;
      // escape the character selection
      if( _viewState == 1 ){ 
        toView = 0;
        _selectionManager.close(); 
      }
      else{
        // Open the character selection
        _selectionManager.open((var char){
          _gridController.changeState(char);
          setView(0);
        });
      }

      setView(toView);
    });
  }

  void setView( int view ){
    if( view < 0 || view >= _views.length ){ throw new IndexError( view, false, "view"); }
    if( view != _viewState ){
      _viewActive.classes.add("hidden");
      _viewActive = _views[view];
      _viewActive.classes.remove("hidden");
      _viewState = view;
    }
  }

  void loadGrid(){

  }
}