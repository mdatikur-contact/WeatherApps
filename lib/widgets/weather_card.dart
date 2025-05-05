import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  // String formatTime(int timestamp) {
  //   final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  //   return DateFormat('hh:mm a').format(date);
  // }

  String formatTime(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  return DateFormat('hh:mm a').format(date.toLocal());
}

  String getWeatherAnimation(String description) {
    final desc = description.toLowerCase();
    if (desc.contains('rain')) return 'assets/rain.json';
    if (desc.contains('clear')) return 'assets/sunny.json';
    if (desc.contains('snow')) return 'assets/snowfall.json';
    return 'assets/cloudy.json';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(179, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(111, 0, 0, 0),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Lottie.asset(
                getWeatherAnimation(weather.description),
                width: 200,
                height: 200,
              ),
              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                weather.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                      Text('Sunrise',
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(formatTime(weather.sunrise),
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.nights_stay_outlined,
                          color: Colors.purple),
                      Text('Sunset',
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(formatTime(weather.sunset),
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Humidity: ${weather.humidity}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Wind: ${weather.windSpeed} m/s',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
