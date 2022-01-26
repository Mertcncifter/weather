part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final List<DailyForecasts?>? weathers;
  WeatherLoadSuccess({required this.weathers});
}

class WeatherLoadFailed extends WeatherState {
  final ResponseState error;
  WeatherLoadFailed({required this.error});
}
