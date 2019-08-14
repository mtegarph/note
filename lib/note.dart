class Note{
  int id;
  String _title;
  String _CreateDate;
  String _note;
  String _updateDate;
  String _SortDate;

  Note(this._title,this._note,this._CreateDate,this._updateDate,this._SortDate);


  Note.map(dynamic obj){
    this._title = obj["title"];
    this._note = obj["note"];
    this._CreateDate = obj["createDate"];
    this._updateDate = obj["updateDate"];
    this._SortDate = obj["sortDate"];
  }

  String get title => _title;
  String get note => _note;
  String get CreateDate => _CreateDate;
  String get updateDate => _updateDate;
  String get SortDate => _SortDate;

Map<String, dynamic> toMap(){
  var map = Map<String, dynamic>();
  map["title"]=_title;
  map["note"]=_note;
  map["CreateDate"]=_CreateDate;
  map["updateDate"]=_updateDate;
  map["SortDate"]=_SortDate;
  return map;
}
void setNoteId(int id){
this.id = id;
}
}