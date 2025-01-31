import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
// ignore: unused_import
import 'package:weather_app/data/repositories/data/models/weather_model.dart';

import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_state.dart';


class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _repository;

  // Fix 1: Initialize with WeatherInitial state
  WeatherCubit(this._repository) : super(WeatherInitial());

  Future<void> fetchWeather(String city) async {
    emit(WeatherLoading());
    try {
      final weather = await _repository.getWeatherByCity(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError("Failed to fetch weather: $e"));
    }
  }

  Future<void> fetchWeatherByLocation() async {
    emit(WeatherLoading());
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      final weather = await _repository.getWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError("Failed to fetch location: $e"));
    }
  }
}