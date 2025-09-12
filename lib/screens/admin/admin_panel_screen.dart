import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _cityController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _websiteController = TextEditingController();
  final _programsController = TextEditingController();
  final _eligibilityCriteriaController = TextEditingController();

  Future<void> _addUniversity() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final programsList = _programsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      await Supabase.instance.client.from('universities').insert({
        'id': int.parse(_idController.text),
        'name': _nameController.text,
        'description': _descriptionController.text,
        'address': _cityController.text, // Using city as address
        'image_url': _imageUrlController.text,
        'website': _websiteController.text,
        'programs': programsList,
        'eligibility_criteria': _eligibilityCriteriaController.text,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('University added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        _formKey.currentState!.reset();
        _clearControllers();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding university: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearControllers() {
    _idController.clear();
    _nameController.clear();
    _descriptionController.clear();
    _cityController.clear();
    _imageUrlController.clear();
    _websiteController.clear();
    _programsController.clear();
    _eligibilityCriteriaController.clear();
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _cityController.dispose();
    _imageUrlController.dispose();
    _websiteController.dispose();
    _programsController.dispose();
    _eligibilityCriteriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel - Add University'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(_idController, 'ID',
                  keyboardType: TextInputType.number),
              _buildTextField(_nameController, 'Name'),
              _buildTextField(_descriptionController, 'Description',
                  maxLines: 3),
              _buildTextField(_cityController, 'Address (City)'),
              _buildTextField(_imageUrlController, 'Image URL'),
              _buildTextField(_websiteController, 'Website'),
              _buildTextField(
                  _programsController, 'Programs (comma-separated)'),
              _buildTextField(
                  _eligibilityCriteriaController, 'Eligibility Criteria',
                  maxLines: 3),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _addUniversity,
                      child: const Text('Add University'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (label == 'ID' && int.tryParse(value) == null) {
            return 'Please enter a valid number for ID';
          }
          return null;
        },
      ),
    );
  }
}
