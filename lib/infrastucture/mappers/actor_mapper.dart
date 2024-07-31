import 'package:cinepediab/domain/entities/actor.dart';
import 'package:cinepediab/infrastucture/models/moviedb/credits_response.dart';
//import 'package:flutter/material.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://img.freepik.com/free-vector/404-error-design-with-laptop_23-2147731478.jpg?size=626&ext=jpg',
      character: cast.character);
}
