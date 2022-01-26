import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/blocs/session/cubit/session_cubit.dart';
import 'package:weather/database/dailyforecasts_database.dart';
import 'package:weather/database/user_database.dart';
import 'package:weather/helper/Response.dart';
import 'package:weather/helper/constants/enums.dart';
import 'package:weather/model/weather/DailyForecasts.dart';
import 'package:weather/repositories/session_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  List<DailyForecasts?>? _weathers = [];
  final SessionCubit sessionCubit;
  WeatherBloc(this.sessionCubit) : super(WeatherInitial()) {}

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherInitialEvent) {
      yield* _mapInitialEventToState();
    }
  }

  Stream<WeatherState> _mapInitialEventToState() async* {
    yield WeatherLoading();
    WeatherResponse? weatherResponse =
        await SessionRepository.getWeathers(sessionCubit.currentUser!.cityId);
    if (weatherResponse != null) {
      if (weatherResponse.Data != null) {
        _weathers = weatherResponse.Data!;
        sessionCubit.updateUser(await UserDatabase.getUser());
        yield WeatherLoadSuccess(weathers: _weathers!);
      } else {
        switch (weatherResponse.Error) {
          case ResponseState.emptydata:
          case ResponseState.noneConnection:
            _weathers = await DailtyForeCastsDatabase.getLast();
            if (_weathers != null && _weathers!.length >= 5) {
              yield WeatherLoadSuccess(weathers: _weathers!);
            }

            break;
          default:
            yield WeatherLoadFailed(error: weatherResponse.Error!);
            break;
        }
      }
    }
  }
}
