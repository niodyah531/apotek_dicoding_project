import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:apotek/dbhelper.dart';
import 'package:apotek/pages/entryform.dart';
import '../models/item.dart'; 

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item> itemList;

  @override //@override fungsi initState() untuk melakukan generate daftar widget berdasarkan data yang sudah ditambahkan
  void initState() {
    super.initState();
    updateListView(); // agar tampilan select db tetap ada meski aplikasi sudah di close
  }

final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    updateListView();
    if (itemList == null) {
      itemList = List<Item>();
    }
    return Scaffold(
      appBar: AppBar(        
        
        title: Text('Apotek Dya Farma', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: 
              Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft, color: Colors.tealAccent,
                    margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 100),
                    child:
                        Row(
                          children: [ Icon(Icons.local_pharmacy, size: 80,),
                            Column( mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [ 
                                Text("Dya Farma", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                                Row( 
                                  children: [ 
                                    Text("PT. Dya Apotek Official Store", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),]),
                                SizedBox(),
                                Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                  Text("Jl. A Yani No.5"),
                                  Text(" Telp.(0358) 1234"),
                                ],),
                              ],
                            ),
                          ],
                        ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Galeri Dya Farma >",style: TextStyle(color: Colors.teal[600]),),
                      Container(
                        color: Colors.grey[400],
                      height: 200,
                      child:
                      ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.all(4.0),
                          child: ClipPath( 
                            child: Image.network(
                              'https://apotektitimurni.com/images/news/kesehatan_apotek.png'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(4.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://d2v9k5u4v94ulw.cloudfront.net/assets/images/5768646/original/eb9c5729-b26b-4ad3-860d-6a67bd98d61e?1605148807.jpg'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(4.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://apoteker.stfi.ac.id/wp-content/uploads/2019/08/Apotek-STFI.jpeg'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(5.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://accurate.id/wp-content/uploads/2020/04/bisnis-apotek.jpg'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(5.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://photo.kontan.co.id/photo/2017/10/03/1816694820p.jpg'),
                          ),
                          ),
                          Padding(padding: const EdgeInsets.all(5.0),
                          child: ClipPath(
                          child: Image.network(
                              'https://media.bareksa.com/cms/media/assets/image/2014/06/7319_80a504652556af738cf4f548865b2427.jpg'),
                          ),
                          ),
                        ],
                      ),
                ),
                    ],
                  ),
                Expanded(
                  child: createListView(),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text("Add Item", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                      onPressed: () async {
                        updateListView();
                        var item = await navigateToEntryForm(context, null);
                        if (item != null) {
                          // memanggil fungsi insert ke database
                          int result = await dbHelper.insert(item);
                          if (result > 0) {
                            createListView();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ]),
    );
  }

  Future<Item> navigateToEntryForm(BuildContext context, Item item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
          child: 
          Card(
            color: Colors.grey[300],
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.visibility),
              ),
              title: 
                  Text(
                    this.itemList[index].merk + "\n" + this.itemList[index].kode,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Rp. " + this.itemList[index].price.toString() 
                  + "\nStock  : " + this.itemList[index].stock.toString(),
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () async {
                  //memangggil fungsi untuk menghapus dari database berdasarkan item
                  dbHelper.delete(this.itemList[index].id);
                  updateListView();
                },
              ),
                onTap: () async {
                var item =
                    await navigateToEntryForm(context, this.itemList[index]);
                //memanggil fungsi untuk edit data
                if (item != null){
                  dbHelper.update(item);
                  updateListView();
                }
              },
            ),
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //select data dari database
      Future<List<Item>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}