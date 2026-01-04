import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  bool isLoading = false;
  String city = '';
  String temperature = '';
  String description = '';
  String error = '';

  final String apiKey = 'cdc1e2d85ccc5d0803451ba58ff1561b';

  Future<void> fetchWeather(String cityName) async {
    setState(() {
      isLoading = true;
      error = '';
    });

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          city = data['name'];
          temperature = data['main']['temp'].toString();
          description = data['weather'][0]['main'];
        });
      } else {
        error = 'City not found';
      }
    } catch (e) {
      error = 'Check your internet connection';
    }

    setState(() {
      isLoading = false;
    });
  }

  IconData getWeatherIcon() {
    switch (description.toLowerCase()) {
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      case 'clear':
        return Icons.wb_sunny;
      default:
        return Icons.cloud_queue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter city name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        if (_cityController.text.isNotEmpty) {
                          fetchWeather(_cityController.text);
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                if (isLoading)
                  const CircularProgressIndicator(color: Colors.white),

                if (error.isNotEmpty)
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),

                if (city.isNotEmpty && !isLoading)
                  WeatherCard(
                    city: city,
                    temperature: temperature,
                    description: description,
                    icon: getWeatherIcon(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String city;
  final String temperature;
  final String description;
  final IconData icon;

  const WeatherCard({
    super.key,
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Column(
          children: [
            Icon(icon, size: 80, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              city,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$temperature °C',
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
