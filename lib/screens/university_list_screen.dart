import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/university_provider.dart';
import '../widgets/university_card.dart';
import '../widgets/main_drawer.dart';

class UniversityListScreen extends StatefulWidget {
  const UniversityListScreen({super.key});

  @override
  State<UniversityListScreen> createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedProgram = 'All Programs';
  // Initialize with default value instead of using late
  List<String> _programOptions = ['All Programs'];
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Fetch universities if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<UniversityProvider>();
      if (provider.universities.isEmpty && !provider.isLoading) {
        provider.fetchUniversities();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _initializeProgramOptions();
      _isInitialized = true;
    }
  }

  void _initializeProgramOptions() {
    final provider = Provider.of<UniversityProvider>(context, listen: false);
    final allPrograms = <String>{};

    for (final university in provider.universities) {
      if (university.programs.isNotEmpty) {
        allPrograms.addAll(university.programs);
      }
    }

    setState(() {
      _programOptions = ['All Programs', ...allPrograms.toList()..sort()];
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universities'),
      ),
      drawer: const MainDrawer(),
      body: Consumer<UniversityProvider>(
        builder: (context, universityProvider, child) {
          if (universityProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (universityProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading universities',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    universityProvider.error!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => universityProvider.fetchUniversities(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              _buildSearchAndFilterSection(),
              Expanded(
                child: _buildUniversitiesList(universityProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchAndFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search universities...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            onChanged: (value) {
              Provider.of<UniversityProvider>(context, listen: false)
                  .setSearchQuery(value);
            },
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedProgram,
                items: _programOptions
                    .map((program) => DropdownMenuItem<String>(
                          value: program,
                          child: Text(program),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedProgram = value;
                    });
                    final filter = value == 'All Programs' ? '' : value;
                    Provider.of<UniversityProvider>(context, listen: false)
                        .setFilterProgram(filter);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUniversitiesList(UniversityProvider provider) {
    final universities = provider.filteredUniversities;

    if (universities.isEmpty) {
      return const Center(
        child: Text('No universities found matching your criteria'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: universities.length,
      itemBuilder: (context, index) {
        return UniversityCard(university: universities[index]);
      },
    );
  }
}
