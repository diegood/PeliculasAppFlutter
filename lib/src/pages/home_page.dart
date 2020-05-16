import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final PeliculasProvider peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Corona-Movies'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTarjetas(), _scroll(context)],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _scroll(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder:(BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(peliculas: snapshot.data, siguientePagina: peliculasProvider.getPopulares,);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                  heightFactor: 5,
                );
              }
            },
          )
          // FutureBuilder(
          //   future: peliculasProvider.getPopulares(),
          //   builder:
          //       (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          //     if (snapshot.hasData) {
          //       return MovieHorizontal(peliculas: snapshot.data);
          //     } else {
          //       return Center(child: CircularProgressIndicator(),heightFactor: 5,);
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
