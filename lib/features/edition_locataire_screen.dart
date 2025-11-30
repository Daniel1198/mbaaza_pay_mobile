import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbaaza_pay/data/models/api_response.dart';
import 'package:mbaaza_pay/data/models/locataire.dart';
import '../data/services/auth_service.dart';
import '../data/services/locataire_service.dart';

class EditionLocataireScreen extends StatefulWidget {
  final Locataire? locataire;

  const EditionLocataireScreen({super.key, this.locataire});

  @override
  State<EditionLocataireScreen> createState() => _EditionLocataireScreenState();
}

class _EditionLocataireScreenState extends State<EditionLocataireScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locataireService = LocataireService();
  final Auth _authService = Auth();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _dateEcheanceController = TextEditingController();

  bool _isLoading = false;
  bool get _isEditing => widget.locataire != null;
  String? bailleurId;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _nomController.text = widget.locataire?.nomComplet ?? '';
      _telephoneController.text = widget.locataire?.telephone ?? '';
      _emailController.text = widget.locataire?.email ?? '';
      _adresseController.text = widget.locataire?.adresseLogement ?? '';
      _montantController.text = widget.locataire?.montantLoyer.toString() ?? '';
      _dateEcheanceController.text = widget.locataire?.dateEcheance.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _telephoneController.dispose();
    _emailController.dispose();
    _adresseController.dispose();
    _montantController.dispose();
    _dateEcheanceController.dispose();
    super.dispose();
  }

  Future _saveLocataire() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final locataireData = {
        'nomComplet': _nomController.text.trim(),
        'telephone': _telephoneController.text.trim(),
        'email': _emailController.text.trim(),
        'adresseLogement': _adresseController.text.trim(),
        'montantLoyer': _montantController.text.trim(),
        'dateEcheance': _dateEcheanceController.text.trim()
      };

      ApiResponse? response;
      if (_isEditing) {
        final id = widget.locataire?.id;
        response = await _locataireService.updateLocataire(id!, locataireData);
      } else {
        response = await _locataireService.createLocataire(locataireData);
      }

      if (mounted) {
        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
              backgroundColor: const Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }

        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur : ${e.toString()}'),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Modifier le locataire' : 'Nouveau locataire',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informations personnelles',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _buildFormField(
                color: Colors.blue,
                controller: _nomController,
                icon: Icons.person_outline,
                label: 'Nom complet',
                placeholder: 'Entrez le nom du locataire',
                validator: (value) => value == null || value.isEmpty
                    ? 'Le nom est requis'
                    : null,
              ),

              _buildFormField(
                color: Colors.green,
                controller: _telephoneController,
                icon: Icons.phone_outlined,
                label: 'Téléphone',
                placeholder: 'Ex: 0700000000',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) => value == null || value.isEmpty
                    ? 'Le numéro de téléphone est requis'
                    : null,
              ),

              _buildFormField(
                color: Colors.amber,
                controller: _emailController,
                icon: Icons.email_outlined,
                label: 'Email',
                placeholder: 'Ex: exemple@mail.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'L’email est requis';
                  }
                  if (!value.contains('@')) {
                    return 'Entrez un email valide';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              const Text(
                'Informations sur le logement',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _buildFormField(
                color: Colors.teal,
                controller: _adresseController,
                icon: Icons.location_on_outlined,
                label: 'Adresse du logement',
                placeholder: 'Ex: Yopougon, Niangon...',
                validator: (value) => value == null || value.isEmpty
                    ? 'L’adresse est requise'
                    : null,
              ),

              _buildFormField(
                color: Colors.purple,
                controller: _montantController,
                icon: Icons.attach_money_outlined,
                label: 'Montant du loyer (F CFA)',
                placeholder: 'Ex: 100000',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) => value == null || value.isEmpty
                    ? 'Le montant est requis'
                    : null,
              ),

              _buildFormField(
                color: Colors.orange,
                controller: _dateEcheanceController,
                icon: Icons.calendar_today_outlined,
                label: 'Date d’échéance du loyer (1–28)',
                placeholder: 'Ex: 5',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La date d’échéance est requise';
                  }
                  final day = int.tryParse(value);
                  if (day == null || day < 1 || day > 28) {
                    return 'La date doit être comprise entre 1 et 28';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _isLoading ? null : _saveLocataire,
                  icon: const Icon(Icons.save_outlined, color: Colors.white),
                  label: Text(
                    _isEditing ? 'Enregistrer les modifications' : 'Ajouter le locataire',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required Color color,
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String placeholder,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          prefixIcon: Icon(icon, color: color),
          filled: true,
          fillColor: color.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
