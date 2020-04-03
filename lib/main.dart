import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:marriageappupdated/bloc/player_bloc_bloc.dart';
import 'package:marriageappupdated/model/game_model.dart';
import 'package:marriageappupdated/screen/game_page.dart';
import 'package:marriageappupdated/screen/initial_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerBlocBloc(),
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: InitialPage()),
    );
  }
}
