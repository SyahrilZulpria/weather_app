import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/extensions/datetime.dart';
import 'package:weather_app/providers/hourly_weather_provider.dart';
import 'package:weather_app/providers/weakly_weather_provider.dart';
import 'package:weather_app/views/gradient_container.dart';
import 'package:weather_app/views/hourly_forecast_view.dart';
import 'package:weather_app/views/weakly_weather_view.dart';

class ForecastReportScreen extends ConsumerWidget {
  final String? searchCity; // null = GPS
  const ForecastReportScreen({super.key, this.searchCity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourlyWeather =
        searchCity == null
            ? ref.watch(hourlyForecastProvider) // GPS
            : ref.watch(hourlyForecastByCityProvider(searchCity!));

    final weeklyWeather =
        searchCity == null
            ? ref.watch(weeklyForecastProvider) // GPS
            : ref.watch(weeklyForecastByCityProvider(searchCity!));
    return GradientContainer(
      children: [
        // Page Title
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Forecast Report',
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 40),

        // Today's date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Today',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              DateTime.now().dateTime,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[900],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Today's forecast
        HourlyForecastView(hourlyWeather: hourlyWeather),

        const SizedBox(height: 20),

        // Next Forecast
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Next Forecast',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Icon(Icons.calendar_month_rounded, color: Colors.white),
          ],
        ),

        const SizedBox(height: 30),

        // Weekly forecast
        WeeklyForecastView(weeklyWeather: weeklyWeather),
      ],
    );
  }
}
