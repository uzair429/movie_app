// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieCacheDataAdapter extends TypeAdapter<MovieCacheData> {
  @override
  final int typeId = 0;

  @override
  MovieCacheData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieCacheData(
      id: fields[0] as int,
      title: fields[1] as String,
      overview: fields[2] as String,
      posterPath: fields[3] as String,
      backdropPath: fields[4] as String,
      genres: (fields[5] as List).cast<int>(),
      releaseDate: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MovieCacheData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.backdropPath)
      ..writeByte(5)
      ..write(obj.genres)
      ..writeByte(6)
      ..write(obj.releaseDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieCacheDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
