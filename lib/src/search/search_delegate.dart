import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  String seleccion = '';

  final peliculas = [
    'spiderman',
    'aquaman',
    'batman',
    'blood',
    'antman',
    'shazam!',
    'spiderman',
    'ironman',
    'capitan America',


  ];

  final peliculasRecientes= [
    'spiderman',
    'capitan America'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    //aca van las acciones del NabBar por lo visto..
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la qzquierda del Nabbar o lo sea digamos
    return IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // aca se crean los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //este comentario no lo iba hacer por que es obvio pero es donde van las sugerencias cuando alguien scribe

    final suggestList = (query.isEmpty) ? peliculasRecientes : peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestList.length,
      itemBuilder: (BuildContext context, int index) {
      return ListTile(
        leading: Icon(Icons.movie),
        title: Text(suggestList[index]),
        onTap: (){
          seleccion = suggestList[index];
          showResults(context);
        },
      );
     },
    );

  }
}
