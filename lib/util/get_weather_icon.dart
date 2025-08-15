// ========================
// OpenWeatherMap Mapping
// ========================
String getOWMWeatherIcon(int code) {
  if (code == 800) return 'assets/icons_cloud/01d.png'; // Clear sky
  if (code == 801) return 'assets/icons_cloud/02d.png'; // Few clouds
  if (code == 802) return 'assets/icons_cloud/03d.png'; // Scattered clouds
  if (code == 803 || code == 804)
    return 'assets/icons_cloud/04d.png'; // Broken/Overcast clouds

  if (code >= 700 && code < 800)
    return 'assets/icons_cloud/50d.png'; // Atmosphere (mist, smoke, haze, fog)
  if (code >= 600 && code < 700) return 'assets/icons_cloud/13d.png'; // Snow
  if (code >= 500 && code < 600) return 'assets/icons_cloud/10d.png'; // Rain
  if (code >= 300 && code < 400) return 'assets/icons_cloud/09d.png'; // Drizzle
  if (code >= 200 && code < 300)
    return 'assets/icons_cloud/11d.png'; // Thunderstorm

  return 'assets/icons_cloud/01d.png'; // Default: sunny
}

// ========================
// Open-Meteo Mapping
// ========================
String getOpenMeteoWeatherIcon(int code) {
  switch (code) {
    // Clear / Cloudy
    case 0:
      return 'assets/icons_cloud/01d.png'; // Clear sky
    case 1:
      return 'assets/icons_cloud/02d.png'; // Mainly clear
    case 2:
      return 'assets/icons_cloud/03d.png'; // Partly cloudy
    case 3:
      return 'assets/icons_cloud/04d.png'; // Overcast

    // Fog
    case 45:
    case 48:
      return 'assets/icons_cloud/50d.png'; // Fog

    // Drizzle
    case 51:
    case 52:
    case 53:
    case 55:
    case 56:
    case 57:
      return 'assets/icons_cloud/09d.png'; // Drizzle

    // Rain
    case 61:
    case 63:
    case 65:
    case 66:
    case 67:
      return 'assets/icons_cloud/10d.png'; // Rain

    // Snow / Ice
    case 71:
    case 73:
    case 75:
    case 77:
    case 85:
    case 86:
    case 87:
      return 'assets/icons_cloud/13d.png'; // Snow

    // Showers
    case 80:
    case 81:
    case 82:
      return 'assets/icons_cloud/09d.png'; // Rain showers

    // Thunderstorm
    case 95:
    case 96:
    case 99:
      return 'assets/icons_cloud/11d.png'; // Thunderstorm

    default:
      return 'assets/icons_cloud/01d.png'; // Default sunny
  }
}

/*

0: Clear sky
1: Mainly clear
2: Partly cloudy
3: Overcast
45: Fog
48: Depositing rime fog
51: Light drizzle
52: Moderate drizzle
53: Heavy drizzle
55: Freezing drizzle
56: Light freezing drizzle
57: Heavy freezing drizzle
61: Slight rain
63: Moderate rain
65: Heavy rain
66: Light freezing rain
67: Heavy freezing rain
71: Slight snowfall
73: Moderate snowfall
75: Heavy snowfall
77: Ice pellets
80: Light rain showers
81: Moderate rain showers
82: Violent rain showers
85: Light snow showers
86: Moderate snow showers
87: Violent snow showers

*/
