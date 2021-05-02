/*Muhammad Reza Pahlepi(181420069)
Apriyo Fadli(181420091)
Arif Athallah(181420065)
Trima Subhan Perbawa(181420055)

Bagian Muhammad Reza Pahlepi(181420069)
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapi/helper/categorydata.dart';
import 'package:newsapi/helper/newsdata.dart';
import 'package:newsapi/model/categorymodel.dart';
import 'package:newsapi/model/newsmodel.dart';
import 'package:newsapi/views/categorypage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ambil  list untuk kategori
  List<CategoryModel> categories = [];
  // ambil list untuk artikel
  List<ArticleModel> articles = [];
  bool _loading = true;

  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.datatobesavedin;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Ini bagian dari bagan nama aplikasi
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Ini untuk menengahkan text
          children: <Widget>[
            Text(
              "Flutter ",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "NEWS API",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ],
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListView.builder(
                        // ini bagian widget untuk menampilkan kattegori
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                            categoryTitle: categories[index].categoryTitle,
                          );
                        },
                      ),
                    ),
                    Container(
                      // widget menampilkan daftar berita
                      child: ListView.builder(
                        itemCount: articles.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return NewsTemplate(
                            urlToImage: articles[index].urlToImage,
                            title: articles[index].title,
                            description: articles[index].description,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// Ini template tampilan kategori
class CategoryTile extends StatelessWidget {
  final String categoryName, imageUrl, categoryTitle;
  CategoryTile({this.categoryName, this.imageUrl, this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    // mendeteksi pengeklikan daftar kategori
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryFragment(
                // Ini untuk mengirim data ke bagian Views categorypage.dart
                category: categoryName.toLowerCase(),
                categorytitle: categoryTitle,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 170,
                  height: 90,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              width: 170,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Membuat template berita

class NewsTemplate extends StatelessWidget {
  String title, description, url, urlToImage;
  NewsTemplate({this.title, this.description, this.urlToImage, this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: urlToImage,
                width: 380,
                height: 200,
                fit: BoxFit.cover,
              )),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
