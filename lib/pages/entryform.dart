import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';

class EntryForm extends StatefulWidget {
  final Item item;

  EntryForm(this.item);
  @override
  EntryFormState createState() => EntryFormState(this.item);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Item item;

  EntryFormState(this.item);

  TextEditingController kodeController = TextEditingController();
  TextEditingController merkController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (item != null) {
      kodeController.text = item.kode;
      merkController.text = item.merk;
      priceController.text = item.price.toString();
      stockController.text = item.stock.toString();
    }
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: item == null ? Text('Input Data Obat') : Text('Edit Data Obat'),
      ),
      body: 
          
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.grey[400],
                  child: Column(
                    children: [
                      Row(
                        children: [ Icon(Icons.local_pharmacy, size: 80, color: Colors.teal,),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Text("PT. Dya Farma", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.teal),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextField(
                    controller: merkController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Kode Obat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                // merk
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: kodeController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Merk Obat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), 
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),

                // price
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
                //stock
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Stock',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),

                //Tombol button
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      //tombol simpan
                      Expanded(
                        child: ElevatedButton(
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            if (item == null) {
                              // add data
                              item = Item(                                 
                                  kodeController.text, 
                                  merkController.text,                                
                                  int.parse(priceController.text),
                                  int.parse(stockController.text));
                            } else {
                              // edit data
                              item.merk = merkController.text;
                              item.kode = kodeController.text;
                              item.price = int.parse(priceController.text);
                              item.stock = int.parse(stockController.text);
                            }
                            //kembali ke layar sebelumnya dengan membawa objek item
                            Navigator.pop(context, item);
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      //tombol cancel
                      Expanded(
                        child: ElevatedButton(
                          child: Text(
                            'Cancel',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Galeri Dya Farma >", style: TextStyle(color: Colors.teal[600]),),
                    Container(
                      color: Colors.teal[100],
                      height: 200,
                      child: ListView( 
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.all(4.0),                 
                          child: ClipPath(
                            child: Image.network(
                              'https://images.bisnis-cdn.com/posts/2021/02/16/1356959/jarum-suntik-bloomberg2.jpg'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(4.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://mmc.tirto.id/image/otf/500x0/2020/03/19/istock-1130459701_ratio-16x9.jpg'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(4.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://www.galerimedika.com/image/cache/catalog/pavblog/img/banner-stetoskop-600x315h.jpg'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(4.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://images.tokopedia.net/img/cache/700/product-1/2019/4/9/5515378/5515378_51a18eee-1d67-4503-8bf4-faa72ea86dbb.JPG'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(4.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://asset-a.grid.id/crop/0x0:0x0/x/photo/2020/09/30/417038370.jpg'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(4.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://ibs.co.id/wp-content/uploads/2019/01/Rak-Tabung-Reaksi-dan-Cara-Penggunaan-1030x686.jpg'),
                          ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
      );
  }
}