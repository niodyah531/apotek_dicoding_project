class Item{
  int _id, _price, _stock;
  String _kode, _merk;

  int get id => _id;

  String get merk => this._merk;
  set merk(String value) => this._merk = value;

  String get kode => this._kode;
  set kode(String value) => this._kode = value;

  get price => this._price;
  set price(value) => this._price = value;

  get stock => this._stock;  
  set stock(value) => this._stock = value;


  // Konstruktor 1
  Item(this._kode,this._merk, this._price,this._stock);


  // konstruktor 2:konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic>map){
    this._id = map['id'];
    this._merk = map['merk'];
    this._kode = map['kode'];
    this._price = map['price'];
    this._stock = map['stock'];

  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['merk'] = merk;
    map['kode'] = kode;
    map['price'] = price;
    map['stock'] = stock;
    return map;
  }

  }