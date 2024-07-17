import 'package:castro_axell_leccion/models/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

class CastroAxellHome extends StatefulWidget {
  const CastroAxellHome({super.key});

  @override
  State<CastroAxellHome> createState() => _CastroAxellHomeState();
}

class _CastroAxellHomeState extends State<CastroAxellHome> {
  Future<List<Anime>> _leerAnimes() async {
    final data =
        await DefaultAssetBundle.of(context).loadString('assets/animes.xml');
    final document = xml.XmlDocument.parse(data);
    final elementos = document.findAllElements('anime');

    return elementos.map((elemento) {
      final titulo = elemento.findElements('titulo').single.text;
      final autor = elemento.findElements('autor').single.text;
      final precio = double.parse(elemento.findElements('precio').single.text);
      final url = elemento.findAllElements('url').single.text;
      return Anime(titulo: titulo, autor: autor, precio: precio, url: url);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text(
          'Archivo XML -Lectura',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: _leerAnimes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final animes = snapshot.data!;
                        return ListView.builder(
                          itemCount: animes.length,
                          itemBuilder: (context, index) {
                            final anime = animes[index];
                            return Card(
                              color: Colors.lightGreen.shade100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Title
                                          Text(
                                            anime.titulo,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text('Autor: ${anime.autor}'),
                                          Text('Precio: ${anime.precio}'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(anime.url,
                                          fit: BoxFit.cover),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      } else {
                        return const Center(
                          child: LinearProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
