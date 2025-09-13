import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/university.dart';
import '../services/notification_service.dart';
import '../services/deadline_reminder_service.dart';

class UniversityProvider with ChangeNotifier {
  List<University> _universities = [];
  List<University> _favorites = [];
  final String _favoritesKey = 'favorites';
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String? _filterProgram;

  List<University> get universities => _universities;
  List<University> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String? get filterProgram => _filterProgram;

  final SupabaseClient _supabase = Supabase.instance.client;
  final NotificationService _notificationService = NotificationService();
  final DeadlineReminderService _deadlineService = DeadlineReminderService();

  UniversityProvider() {
    _loadFavorites();
    _initializeDeadlineService();
  }

  Future<void> _initializeDeadlineService() async {
    await _deadlineService.initialize();
  }

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

  // Load favorites from SharedPreferences
  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getStringList(_favoritesKey);

      if (favoritesJson != null) {
        _favorites = favoritesJson
            .map((json) => University.fromJson(jsonDecode(json)))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      // Handle errors appropriately
      if (kDebugMode) {
        print('Error loading favorites: $e');
      }
    }
  }

  // Save favorites to SharedPreferences
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = _favorites
          .map((university) => jsonEncode(university.toJson()))
          .toList();
      await prefs.setStringList(_favoritesKey, favoritesJson);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving favorites: $e');
      }
    }
  }

  void toggleFavorite(University university) {
    final isExist = _favorites.any((element) => element.id == university.id);
    if (isExist) {
      _favorites.removeWhere((element) => element.id == university.id);
      _notificationService.showUnfavoriteNotification(
        universityName: university.name,
      );
    } else {
      _favorites.add(university);
      _notificationService.showFavoriteNotification(
        universityName: university.name,
      );
    }
    _saveFavorites();

    // Check deadlines when favorites change
    _checkDeadlineReminders();

    notifyListeners();
  }

  bool isFavorite(University university) {
    return _favorites.any((element) => element.id == university.id);
  }

  Future<void> checkDeadlineReminders() async {
    await _deadlineService.checkAndSendDeadlineReminders(_favorites);
  }

  Future<void> _checkDeadlineReminders() async {
    try {
      await _deadlineService.checkAndSendDeadlineReminders(_favorites);
    } catch (e) {
      if (kDebugMode) {
        print('Error checking deadline reminders: $e');
      }
    }
  }

  List<Map<String, dynamic>> getUpcomingDeadlines() {
    return _deadlineService.getUpcomingDeadlines(_favorites);
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
