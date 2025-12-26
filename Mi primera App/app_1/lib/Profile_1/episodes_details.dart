import 'package:app_1/models/episodes_model.dart';
import 'package:flutter/material.dart';

class EpisodeDetailsPage extends StatelessWidget {
  final EpisodeModel episode;

  const EpisodeDetailsPage({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(episode.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Título del episodio
            Text(
              episode.title,
              style: Theme.of(context).textTheme.headlineLarge,  // Usamos headlineLarge como estilo
            ),
            SizedBox(height: 8),
            // Sinopsis del episodio
            Text(
              episode.synopsis,
              style: Theme.of(context).textTheme.bodyLarge,  // Usamos bodyLarge como estilo
            ),
            SizedBox(height: 16),
            // Información adicional del episodio
            Row(
              children: [
                Text('Season: ${episode.season}', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text('Episode: ${episode.episodeNumber}', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Airdate: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(episode.airdate.toString().split(' ')[0]),  // Solo mostrar la fecha (sin hora)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
