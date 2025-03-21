// To parse this JSON data, do
//
//     final historique = historiqueFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

Historique historiqueFromJson(String str) =>
    Historique.fromJson(json.decode(str));

String historiqueToJson(Historique data) => json.encode(data.toJson());

class Historique {
  int id;
  String libelle;
  String? description;
  int montant;
  DateTime date;
  int type;

  Historique({
    required this.id,
    required this.libelle,
    this.description,
    required this.montant,
    required this.date,
    required this.type,
  });

  //Titre de l'entrée ou la sortie
  String get troncateLabel {
    return libelle.length > 20 ? "${libelle.substring(0, 20)}..." : libelle;
  }

  //Icone pour l'entrée ou la sortie
  String get icon {
    if (type == 0) {
      return "assets/images/entree.png";
    } else {
      return "assets/images/sortie.png";
    }
  }

  //Formatage du type
  String get typeLabel {
    return type == 0 ? "Entrée" : "Sortie";
  }

  //Formatage de la date
  String get dateValue {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  factory Historique.fromJson(Map<String, dynamic> json) => Historique(
        id: json["id"],
        libelle: json["libelle"],
        description: json["description"],
        montant: json["montant"],
        date: DateTime.parse(json["date"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "description": description,
        "montant": montant,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "type": type,
      };
}
