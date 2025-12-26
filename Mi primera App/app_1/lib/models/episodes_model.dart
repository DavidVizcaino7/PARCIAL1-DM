import 'dart:convert';

EpisodeModel episodeModelFromJson(String str) => EpisodeModel.fromJson(json.decode(str));

String episodeModelToJson(EpisodeModel data) => json.encode(data.toJson());

class EpisodeModel {
  int id;
  String title;
  int season;
  int episodeNumber;
  DateTime airdate;
  String synopsis;
  String imageUrl;
  String guestStars;

  EpisodeModel({
    required this.id,
    required this.title,
    required this.season,
    required this.episodeNumber,
    required this.airdate,
    required this.synopsis,
    required this.imageUrl,
    required this.guestStars,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    // Verificar y parsear la fecha de aire, manejar valores nulos o vacíos
    DateTime parsedAirdate;
    try {
      if (json['airdate'] != null && json['airdate'].isNotEmpty) {
        parsedAirdate = DateTime.parse(json['airdate']);
      } else {
        parsedAirdate = DateTime.now();  // Asignar la fecha actual si 'airdate' es vacío o nulo
      }
    } catch (e) {
      parsedAirdate = DateTime.now();  // Asignar la fecha actual si la fecha es inválida
    }

    return EpisodeModel(
      id: json['id'],
      title: json['name'] ?? 'No title available',
      season: json['season'] ?? 0,
      episodeNumber: json['episode_number'] ?? 0,
      airdate: parsedAirdate,  // Usar la fecha procesada
      synopsis: json['synopsis'] ?? 'No synopsis available',
      imageUrl: json['image_path'] ?? '',  // Si 'image_path' es null, asignar cadena vacía
      guestStars: json['guest_stars'] ?? '',  // Si 'guest_stars' es null, asignar cadena vacía
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "season": season,
        "episode_number": episodeNumber,
        "airdate": "${airdate.year.toString().padLeft(4, '0')}-${airdate.month.toString().padLeft(2, '0')}-${airdate.day.toString().padLeft(2, '0')}",  // Formatear la fecha
        "synopsis": synopsis,
        "image_path": imageUrl,
        "guest_stars": guestStars,
      };
}
