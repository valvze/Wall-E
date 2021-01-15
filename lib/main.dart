import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/Bloc/categoryWallpaperBloc.dart';
import 'package:wall_e/Bloc/searchWallpaperBloc.dart';
import 'package:wall_e/Bloc/wallpaperBloc.dart';
import 'package:wall_e/Screens/HomePage.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperBloc(),
      child: BlocProvider(
        create: (context) => SearchWallpaperBloc(),
        child: BlocProvider(
          create: (context) => CategoryWallpaperBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wall-E',
            theme: ThemeData(
                brightness: Brightness.dark,

                accentColor: Colors.white,
                cursorColor: Colors.black,
                dialogBackgroundColor: Colors.black,
                primaryColor: Colors.black),
            // theme: ThemeData(
            //     brightness: Brightness.light,
            //     cardColor: Colors.white38,
            //     accentColor: Colors.black,
            //     cursorColor: Colors.black,
            //     dialogBackgroundColor: Colors.white,
            //     primaryColor: Colors.white),
            // darkTheme: ThemeData(
            //     brightness: Brightness.dark,
            //     accentColor: Colors.white,
            //     cursorColor: Colors.white,
            //     primaryColor: Colors.black,
            //     dialogBackgroundColor: Colors.black,
            //     cardColor: Colors.white38),
            home: MyHomePage('Wall-E'),
          ),
        ),
      ),
    );
  }
}
