import 'package:assignment_ddd/applications/bloc/connectivity_bloc/bloc.dart';
import 'package:assignment_ddd/presentation/services/locationServices.dart';
import 'package:assignment_ddd/presentation/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'domain/models/save.dart';
import 'firebase_options.dart';
import 'utils/routes/routes_imports.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  LocationService.getCurrentLocation();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
   Hive.registerAdapter(SaveDataAdapter());
  await Hive.openBox<List<SaveData>>("savedatas");
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext context)=>InternetBloc(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
          // initialRoute: RoutesName.splashScreen,
          // onGenerateRoute: Routes.generateRoute
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
