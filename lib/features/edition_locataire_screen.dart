import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbaaza_pay/core/constants/colors.dart';

class EditionLocataireScreen extends StatefulWidget {
  final Map<String, String>? locataire; // null pour ajouter, données pour éditer

  const EditionLocataireScreen({
    super.key,
    this.locataire,
  });

  @override
  State<EditionLocataireScreen> createState() => _EditionLocataireScreenState();
}

class _EditionLocataireScreenState extends State<EditionLocataireScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers pour les champs
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();

  bool _isLoading = false;

  bool get _isEditing => widget.locataire != null;

  @override
  void initState() {
    super.initState();

    // Pré-remplir les champs si on édite un locataire existant
    if (_isEditing) {
      _nomController.text = widget.locataire!['nom'] ?? '';
      _telephoneController.text = widget.locataire!['telephone'] ?? '';
      _emailController.text = widget.locataire!['email'] ?? '';
      _adresseController.text = widget.locataire!['adresse'] ?? '';
      _montantController.text = widget.locataire!['montant'] ?? '';
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _telephoneController.dispose();
    _emailController.dispose();
    _adresseController.dispose();
    _montantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Informations personnelles'),
                    const SizedBox(height: 16),
                    _buildPersonalInfoFields(),

                    const SizedBox(height: 32),

                    _buildSectionTitle('Informations sur le logement'),
                    const SizedBox(height: 16),
                    _buildLogementInfoFields(),
                  ],
                ),
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          )
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        _isEditing ? 'Éditer le locataire' : 'Ajouter un locataire',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildPersonalInfoFields() {
    return Column(
      children: [
        _buildFormField(
          controller: _nomController,
          icon: Icons.person_outline,
          label: 'Nom complet',
          placeholder: 'Cliquez ici pour saisir',
          color: AppColors.primary,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Le nom est requis';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        _buildFormField(
          controller: _telephoneController,
          icon: Icons.phone_outlined,
          label: 'Téléphone',
          placeholder: 'Cliquez ici pour saisir',
          color: AppColors.secondary,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Le téléphone est requis';
            }
            if (value.length < 8) {
              return 'Numéro de téléphone invalide';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        _buildFormField(
          color: Colors.purple,
          controller: _emailController,
          icon: Icons.email_outlined,
          label: 'E-mail',
          placeholder: 'Cliquez ici pour saisir',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value)) {
                return 'Email invalide';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLogementInfoFields() {
    return Column(
      children: [
        _buildFormField(
          color: Colors.yellow,
          controller: _adresseController,
          icon: Icons.location_on_outlined,
          label: 'Adresse exacte du logement',
          placeholder: 'Cliquez ici pour saisir',
          maxLines: 2,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'L\'adresse est requise';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        _buildFormField(
          color: Colors.green,
          controller: _montantController,
          icon: Icons.monetization_on_outlined,
          label: 'Montant du loyer',
          placeholder: 'Cliquez ici pour saisir',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Le montant est requis';
            }
            final amount = int.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Montant invalide';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String placeholder,
    required Color color,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color.withAlpha(25),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackSoft,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              maxLines: maxLines,
              validator: validator,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFFE5E7EB),
                  width: 1,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Annuler',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: ElevatedButton(
              onPressed: _isLoading ? null : _saveLocataire,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : Text(
                _isEditing ? 'Modifier' : 'Enregistrer',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveLocataire() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simuler une requête réseau
      await Future.delayed(const Duration(seconds: 2));

      // Créer l'objet locataire
      final locataireData = {
        'nom': _nomController.text.trim(),
        'telephone': _telephoneController.text.trim(),
        'email': _emailController.text.trim(),
        'adresse': _adresseController.text.trim(),
        'montant': _montantController.text.trim(),
      };

      if (mounted) {
        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing
                  ? 'Locataire modifié avec succès!'
                  : 'Locataire ajouté avec succès!',
            ),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

        // Retourner à la page précédente avec les données
        Navigator.of(context).pop(locataireData);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
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
}