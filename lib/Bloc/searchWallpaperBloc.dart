import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/Bloc/wallpaperEvent.dart';
import 'package:wall_e/Bloc/wallpaperState.dart';
import 'package:wall_e/Model/wallpaper.dart';
import 'package:wall_e/const.dart';
import 'package:http/http.dart' as http;

class SearchWallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  List<Wallpaper> _searchWallpaper = List<Wallpaper>();

  @override
  WallpaperState get initialState => SearchWallpaperIsLoading();

  @override
  Stream<WallpaperState> mapEventToState(WallpaperEvent event) async* {
    if (event is SearchWallpaper) {
      yield SearchWallpaperIsLoading();
      try {
        var response = await http.get(
            Uri.encodeFull(searchEndPoint + event.string + perPageLimit),
            headers: {
              "Accept": "application/json",
              "Authorization": "$apiKey"
            });
        var data = jsonDecode(response.body)["photos"];
        _searchWallpaper = List<Wallpaper>();
        for (var i = 0; i < data.length; i++) {
          _searchWallpaper.add(Wallpaper.fromMap(data[i]));
        }
        yield SearchWallpaperIsLoaded(_searchWallpaper);
      } catch (_) {
        yield SearchWallpaperIsNotLoaded();
      }
    }
  }
}
