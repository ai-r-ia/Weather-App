class City {
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;

  City(
      {required this.isSelected,
      required this.city,
      required this.country,
      required this.isDefault});
  static List<City> citiesList = [
    City(
      isSelected: true,
      city: 'Delhi',
      country: 'India',
      isDefault: true,
    ),
    City(
      isSelected: false,
      city: 'London',
      country: 'United Kingdom',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Japan',
      country: 'Tokyo',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Beijing',
      country: 'China',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Paris',
      country: 'France',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Sydney',
      country: 'Australia',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Rome',
      country: 'Italy',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Lagos',
      country: 'Nigeria',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Amsterdam',
      country: 'Netherlands',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Barcelona',
      country: 'Spain',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Miami',
      country: 'USA',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Berlin',
      country: 'Germany',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Toronto',
      country: 'Canada',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Vienna',
      country: 'Austria',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Brussels',
      country: 'Belgium',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Nairobi',
      country: 'Kenya',
      isDefault: false,
    ),
  ];
  static List<City> getSelectedCities() {
    List<City> selectedCities = City.citiesList;
    return selectedCities.where((city) => city.isSelected == true).toList();
  }
}
