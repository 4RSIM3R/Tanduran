import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:tanduran/animation/FadeAnimation.dart';

class Detail extends StatelessWidget {

  String deskripsi;
  String image;

  @override
  Widget build(BuildContext context) {
    final name = Sailor.param(context, 'name');
    if (name == "Daun Karat") {
      image = "assets/images/daunkarat.jpg";
      deskripsi = "Seperti umumnya jenis penyakit yang disebabkan oleh jamur, penyakit karat daun juga sangat mudah menular ke tanaman sehat lainnya. Oleh sebab itu, jika tidak dikendalikan secara tepat, maka penyakit ini akan sangat merugikan. Biasanya penyakit ini mulai muncul saat musim hujan dan kondisi kelembaban cukup tinggi.";
    }else if (name == "Busuk Batang") {
      image = "assets/images/busukbatang.jpg";
      deskripsi = "Penyakit ini umumnya menyerang bagian pangkal batang, atau bagian sambungan antara batang atas dan bawah Gejala awal tampak berupa bercak basah yang berwarna gelap pada kulit batang.";
    }else{
      image = "assets/images/layufusarium.jpg";
      deskripsi = "Layu fusarium adalah salah satu jenis penyakit yang umum menyerang tanaman budidaya. Serangan penyakit fusarium ini dapat dikategorikan sebagai serangan penyakit yang berbahaya, karena dapat menyebabkan kerugian yang cukup besar bagi para petani.";
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 450,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.black
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            Colors.black.withOpacity(.3)
                          ]
                        ),
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover
                        )
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(1, Text(name, style: 
                              TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40)
                            ,)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(1.6, Text(deskripsi, 
                        style: TextStyle(color: Colors.grey, height: 1.4),)),
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
        ],
      ),
    );
  }
}