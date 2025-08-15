import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/extensions/datetime.dart';
import 'package:weather_app/page/forecast_report_screen.dart';
import 'package:weather_app/page/login.dart';
import 'package:weather_app/providers/current_weather_provider.dart';
import 'package:weather_app/providers/get_weather_by_city_provider.dart';
import 'package:weather_app/providers/hourly_weather_provider.dart';
import 'package:weather_app/util/ButtonOval.dart';
import 'package:weather_app/views/gradient_container.dart';
import 'package:weather_app/views/hourly_forecast_view.dart';
import 'package:weather_app/views/info_weather.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  String? searchCity; // null = pakai GPS
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Awal load, ambil data GPS
    searchCity = null;
  }

  @override
  Widget build(BuildContext context) {
    final hourlyWeather =
        searchCity == null
            ? ref.watch(hourlyForecastProvider) // GPS
            : ref.watch(hourlyForecastByCityProvider(searchCity!));
    final weatherAsync =
        searchCity == null
            ? ref.watch(currentWheatherProvider) // provider GPS
            : ref.watch(
              weatherByCityNameProvider(searchCity!),
            ); // provider by city name
    return weatherAsync.when(
      data: (weather) {
        return Scaffold(
          body: GradientContainer(
            children: [
              // Search bar
              SizedBox(
                width: 320,
                height: 50,
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    setState(() {
                      searchCity = value.isNotEmpty ? value : null;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Search City",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_forward, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          searchCity =
                              _controller.text.isNotEmpty
                                  ? _controller.text
                                  : null;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(width: double.infinity),
              Text(
                "Selamat datang di Applikasi\nWeather App",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                DateTime.now().dateTime,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Cuaca utama
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    child: Image.asset(
                      'assets/icons_cloud/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // biar tetap di tengah
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: 20),
                      SizedBox(width: 4), // jarak antara icon & text
                      Text(
                        weather.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    weather.weather[0].description,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Weather info
              WeatherInfo(weather: weather),

              SizedBox(height: 30),

              //!View Hourly Forecast
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ForecastReportScreen(),
                        ),
                      );
                    },
                    child: Text('View full forecast'),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Hourly forecast
              HourlyForecastView(hourlyWeather: hourlyWeather),

              SizedBox(height: 30),
              ButtonOval(
                width: MediaQuery.of(context).size.width,
                label: "Log Out",
                onPressed: () {
                  FocusScope.of(
                    context,
                  ).unfocus(); // <--- add this biar ga balik fokus ke textfield
                  //HomePage();
                  print("masuk");
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
