import 'package:flutter/material.dart';
import 'package:weather_app/data/repositories/data/models/weather_model.dart';


class WeatherDisplay extends StatelessWidget{
  final WeatherModel weather;
  const WeatherDisplay({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              weather.city,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '${weather.temperature.toStringAsFixed(1)}℃',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(weather.condition),
            const SizedBox(height: 16),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                Column(
                  children: [
                    const Text('Humidity'),
                    Text('${weather.humidity}%'),
                  ],
                ),
                Column(
                  children: [
                    const Text('Wind Speed'),
                    Text('${weather.windSpeed} km/h'),
                  ],
                 ),
                ],
               ),
               Image.network(
               'https://openweathermap.org/img/w/${weather.iconCode}.png',
               width: 64,
               height: 64,
               )
              ],
             ),
            ),
           );
  }

}