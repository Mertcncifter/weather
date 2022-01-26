import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/src/provider.dart';
import 'package:weather/blocs/session/cubit/session_cubit.dart';
import 'package:weather/blocs/weather/bloc/weather_bloc.dart';
import 'package:weather/helper/constants/app_resource_constants.dart';
import 'package:weather/helper/constants/enums.dart';
import 'package:weather/presentation/widget/ExtraWeather.dart';
import 'package:weather/presentation/widget/TodayWeather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> onBackKey() async {
    return true;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackKey,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  ResourceConstants.deviceHeight(context) * .08),
              child: _header()),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.black),
                  title: Text("Çıkış Yap"),
                  onTap: () {
                    context.read<SessionCubit>().signOut();
                  },
                ),
              ],
            ),
          ),
          body: _body(),
        ));
  }

  Widget _header() {
    return SafeArea(
      child: Container(
          child: AppBar(
        backgroundColor: ResourceConstants.appBG,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(
            Icons.settings,
            color: Colors.black,
          ),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        centerTitle: true,
        title: Text("Hava Durumu", style: ResourceConstants.appbarTextStyle),
      )),
    );
  }

  Widget _body() {
    return BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoadFailed) {
            switch (state.error) {
              case ResponseState.locationdenied:
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Hata'),
                          content: Text("Lütfen konum izni veriniz"),
                          actions: [
                            new TextButton(
                              child: new Text("İzin ver"),
                              onPressed: () {
                                context
                                    .read<WeatherBloc>()
                                    .add(WeatherInitialEvent());
                                Navigator.pop(context);
                              },
                            ),
                            new TextButton(
                              child: Text("Kapat"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ));
                break;
              case ResponseState.locationpermanentlyDenied:
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Hata'),
                          content: Text("Lütfen ayarlardan Konum izni veriniz"),
                          actions: [
                            new TextButton(
                              child: new Text("Ayarlara git"),
                              onPressed: () async {
                                await openAppSettings();
                                Navigator.pop(context);
                              },
                            ),
                            new TextButton(
                              child: Text("Kapat"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ));
                break;
              default:
            }
          }
        },
        child: _weatherList());
  }

  Widget _weatherList() {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (_, state) {
      if (state is WeatherLoadSuccess) {
        return WeeatherList(state: state);
      } else if (state is WeatherLoading || state is WeatherInitial) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}

class WeeatherList extends StatelessWidget {
  final WeatherLoadSuccess state;

  const WeeatherList({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return state.weathers!.length > 0
        ? Stack(alignment: Alignment.bottomCenter, children: [
            Align(child: TodayWeather(weather: state.weathers![0]!)),
            SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.weathers!.length,
                      itemBuilder: (_, index) {
                        final weather = state.weathers![index];
                        return index == 0
                            ? SizedBox()
                            : ExtraWeather(
                                weather: weather!,
                                checkdivider:
                                    state.weathers!.length - 1 == index);
                      }),
                ]))
          ])
        : SizedBox();
  }
}
