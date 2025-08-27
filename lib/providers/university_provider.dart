//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/university.dart';
import '../models/application_step.dart';
import '../data/universities_data.dart';

class UniversityProvider extends ChangeNotifier {
  List<University> _universities = [];
  List<String> _favorites = [];
  final SharedPreferences _preferences;
  String _searchQuery = '';
  String _filterProgram = '';

  bool _isLoading = false;
  String? _errorMessage;

  UniversityProvider(this._preferences) {
    _loadUniversities();
    _loadFavorites();
  }

  // Getters for state
  List<University> get universities => _universities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<University> get filteredUniversities {
    if (_searchQuery.isEmpty && _filterProgram.isEmpty) {
      return _universities;
    }

    return _universities.where((university) {
      bool matchesSearch = _searchQuery.isEmpty ||
          university.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          university.description
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      bool matchesFilter = _filterProgram.isEmpty ||
          university.programs.any((program) =>
              program.toLowerCase().contains(_filterProgram.toLowerCase()));

      return matchesSearch && matchesFilter;
    }).toList();
  }

  List<University> get favorites {
    return _universities
        .where((university) => _favorites.contains(university.id))
        .toList();
  }

  // Added getTopUniversities method for the home screen
  List<University> getTopUniversities(int count) {
    // For now, simply return the first `count` universities
    // In a real app, you might sort by rating, popularity, etc.
    return _universities.take(count).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilterProgram(String program) {
    _filterProgram = program;
    notifyListeners();
  }

  bool isFavorite(String universityId) {
    return _favorites.contains(universityId);
  }

  void toggleFavorite(String universityId) {
    if (_favorites.contains(universityId)) {
      _favorites.remove(universityId);
    } else {
      _favorites.add(universityId);
    }
    _saveFavorites();
    notifyListeners();
  }

  University? getUniversityById(String id) {
    try {
      return _universities.firstWhere((uni) => uni.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> _loadUniversities() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _universities = getUniversitiesData();
      _isLoading = false;
    } catch (e) {
      _errorMessage = "Failed to load university data: ${e.toString()}";
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> reloadUniversities() async {
    await _loadUniversities();
  }

  void _loadFavorites() {
    final favoritesJson = _preferences.getStringList('favorites');
    if (favoritesJson != null) {
      _favorites = favoritesJson;
    }
  }

  void _saveFavorites() {
    _preferences.setStringList('favorites', _favorites);
  }

  List<Map<String, dynamic>> getUpcomingDeadlines() {
    final List<Map<String, dynamic>> deadlines = [];
    for (var university in _universities) {
      for (var step in university.applicationSteps) {
        if (step.deadline != null && step.deadline!.isAfter(DateTime.now())) {
          deadlines.add({
            'university': university,
            'step': step,
          });
        }
      }
    }
    deadlines.sort((a, b) => (a['step'] as ApplicationStep)
        .deadline!
        .compareTo((b['step'] as ApplicationStep).deadline!));
    return deadlines;
  }
}
