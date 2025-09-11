//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/university.dart';

class UniversityProvider with ChangeNotifier {
  List<University> _universities = [];
  List<University> _favoriteUniversities = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String? _filterProgram;

  List<University> get universities => _universities;
  List<University> get favoriteUniversities => _favoriteUniversities;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String? get filterProgram => _filterProgram;

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> fetchUniversities() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _supabase
          .from('universities')
          .select('*, degrees(*), application_steps(*)')
          .order('id');

      if (response.isEmpty) {
        _universities = [];
      } else {
        _universities = (response as List<dynamic>)
            .map((universityData) => University.fromJson(universityData))
            .toList();
      }
    } catch (e) {
      _error = 'Failed to fetch universities: ${e.toString()}';
      _universities = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(University university) {
    if (_favoriteUniversities.contains(university)) {
      _favoriteUniversities.remove(university);
    } else {
      _favoriteUniversities.add(university);
    }
    notifyListeners();
  }

  bool isFavorite(University university) {
    return _favoriteUniversities.contains(university);
  }

  List<University> searchUniversities(String query) {
    if (query.isEmpty) {
      return _universities;
    }
    return _universities.where((university) {
      return university.name.toLowerCase().contains(query.toLowerCase()) ||
          university.description.toLowerCase().contains(query.toLowerCase()) ||
          university.programs.any(
              (program) => program.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }

  List<University> filterByType(String? type) {
    if (type == null || type.isEmpty) {
      return _universities;
    }
    return _universities
        .where(
            (university) => university.type.toLowerCase() == type.toLowerCase())
        .toList();
  }

  University? getUniversityById(String id) {
    try {
      return _universities.firstWhere((university) => university.id == id);
    } catch (e) {
      return null;
    }
  }

  List<University> getTopUniversities(int count) {
    return _universities.take(count).toList();
  }

  List<Map<String, dynamic>> getUpcomingDeadlines() {
    List<Map<String, dynamic>> deadlines = [];

    for (var university in _universities) {
      for (var step in university.applicationSteps) {
        if (step.deadline?.isAfter(DateTime.now()) == true) {
          deadlines.add({
            'university': university.name,
            'step': step.title,
            'deadline': step.deadline,
          });
        }
      }
    }

    // Sort by deadline
    deadlines.sort((a, b) => a['deadline'].compareTo(b['deadline']));

    return deadlines.take(5).toList(); // Return top 5 upcoming deadlines
  }

  List<University> get filteredUniversities {
    List<University> filtered = _universities;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((university) {
        return university.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            university.description
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            university.programs.any((program) =>
                program.toLowerCase().contains(_searchQuery.toLowerCase()));
      }).toList();
    }

    // Apply program filter
    if (_filterProgram != null && _filterProgram!.isNotEmpty) {
      filtered = filtered
          .where((university) => university.programs.any((program) =>
              program.toLowerCase().contains(_filterProgram!.toLowerCase())))
          .toList();
    }

    return filtered;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilterProgram(String? program) {
    _filterProgram = program;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _filterProgram = null;
    notifyListeners();
  }
}
