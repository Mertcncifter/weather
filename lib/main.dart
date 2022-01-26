import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/weather/bloc/weather_bloc.dart';
import 'package:weather/helper/bloc_observer.dart';
import 'package:weather/presentation/screens/auth/login_screen.dart';
import 'package:weather/presentation/screens/home/home_screen.dart';
import 'blocs/session/cubit/session_cubit.dart';
import 'helper/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Utils.Box();
  Bloc.observer = AppBlocObserver();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<SessionCubit>(create: (context) => SessionCubit()),
    BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc(BlocProvider.of<SessionCubit>(context))
          ..add(WeatherInitialEvent())),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      home: BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
        if (state is Authenticated) {
          return HomeScreen();
        } else if (state is UnAuthenticad) {
          return LoginScreen();
        }
        return LoginScreen();
      }),
    );
  }
}
