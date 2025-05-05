import 'package:flutter/material.dart';
import 'package:myapp/models/weather_model.dart';
import 'package:myapp/services/weather_services.dart';
import 'package:myapp/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  final TextEditingController _controller = TextEditingController();
  bool _isloading = false;
  Weather? _weather;

  void _getWeather() async {
    setState(() {
      _isloading = true;
    });

    try {
      final weather = await _weatherServices.featchWeather(_controller.text);
      if (mounted) {
        setState(() {
          _weather = weather;
          _isloading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error fetching weather data')),
        );
        setState(() {
          _isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: _weather != null &&
                  _weather!.description.toLowerCase().contains('rain')
              ? const LinearGradient(
                  colors: [Color.fromARGB(91, 158, 158, 158), Color.fromARGB(255, 97, 25, 212)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : _weather != null &&
                      _weather!.description.toLowerCase().contains('clear')
                  ? const LinearGradient(
                      colors: [Colors.orangeAccent, Color.fromARGB(255, 133, 15, 207)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : const LinearGradient(
                      colors: [Color.fromARGB(255, 71, 7, 121), Color.fromARGB(255, 224, 102, 14)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                const Text(
                  'Weather App',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _controller,
                  style: const TextStyle(color: Color.fromARGB(255, 234, 227, 227)),
                  decoration: InputDecoration(
                    hintText: "Enter your City name",
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    filled: true,
                    fillColor: const Color.fromARGB(87, 225, 19, 232),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 225, 19, 232),
                    foregroundColor: const Color.fromARGB(255, 227, 227, 227),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Weather',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                if (_isloading)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                if (_weather != null) WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
