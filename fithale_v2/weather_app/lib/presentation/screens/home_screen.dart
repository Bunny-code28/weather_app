import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/widgets/weather_display.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title: const Text('Weather APP')),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 20),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if(state is WeatherLoading){
                  return const SpinKitFadingCircle(size: 50,color:Colors.blueAccent);
                } else if (state is WeatherLoaded) {
                  return WeatherDisplay(weather: state.weather);
                } else if (state is WeatherError) {
                  return Text(state.message, style: const TextStyle(color: Colors.redAccent));
              }
              return const Text('Enter the name of a city or use your location');
              },
           ),
        ],
      ),
    ),

    floatingActionButton: FloatingActionButton(
      onPressed: () => context.read<WeatherCubit>().fetchWeatherByLocation(),
      child: const Icon(Icons.location_on),
    ),
  );
}

Widget _buildSearchBar(BuildContext context) {
  return TextField(
    controller: _cityController,
    decoration: InputDecoration(
      hintText: 'Enter City Name',
      suffixIcon:IconButton(
        icon:const Icon(Icons.search),
        onPressed: () => context.read<WeatherCubit>().fetchWeather(_cityController.text),
      ),
    ),
  );
}
}