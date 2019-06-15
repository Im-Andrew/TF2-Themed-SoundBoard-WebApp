import 'dart:html';
import "dart:async";

class HTMLTemplate{
  String _url;
  String _html;
  HTMLTemplate(this._url):_html="";
  
  Future<bool> load(){
    if( _html.isNotEmpty ){ return new Future.value(true); }
    return HttpRequest.getString(_url).then( (val){
      _html = val;
      return _html.isNotEmpty;
    });   
  }
  
  Element generate( Map<String, String> swaps ){
    String copy = _html;
    swaps.forEach( (key,value){
    	copy = copy.replaceAll( "{${key}}", value);
    });
    return new Element.html( copy );
  }
}