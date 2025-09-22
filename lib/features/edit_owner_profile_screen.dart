import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class EditOwnerProfileScreen extends StatefulWidget {
  const EditOwnerProfileScreen({super.key});

  @override
  State<EditOwnerProfileScreen> createState() => _EditOwnerProfileScreenState();
}

class _EditOwnerProfileScreenState extends State<EditOwnerProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hasChanges = false;

  // Controllers pour les champs de texte
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Controllers pour les liens QR Code
  final TextEditingController _waveController = TextEditingController();
  final TextEditingController _orangeController = TextEditingController();
  final TextEditingController _mtnController = TextEditingController();
  final TextEditingController _moovController = TextEditingController();
  final TextEditingController _customController = TextEditingController();

  String? _profileImagePath;
  bool _isLoading = false;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'name': 'Wave',
      'icon': Icons.waves_rounded,
      'color': const Color(0xFF00D2FF),
      'controller': null,
    },
    {
      'name': 'Orange Money',
      'icon': Icons.smartphone_rounded,
      'color': const Color(0xFFFF6600),
      'controller': null,
    },
    {
      'name': 'MTN Mobile Money',
      'icon': Icons.phone_android_rounded,
      'color': const Color(0xFFFFCC00),
      'controller': null,
    },
    {
      'name': 'Moov Money',
      'icon': Icons.account_balance_wallet_rounded,
      'color': const Color(0xFF00B4FF),
      'controller': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Assigner les controllers aux méthodes de paiement
    paymentMethods[0]['controller'] = _waveController;
    paymentMethods[1]['controller'] = _orangeController;
    paymentMethods[2]['controller'] = _mtnController;
    paymentMethods[3]['controller'] = _moovController;

    // Charger les données existantes
    _loadExistingData();

    // Écouter les changements
    _setupChangeListeners();
  }

  void _loadExistingData() {
    // Simuler le chargement des données existantes
    _fullNameController.text = 'Jean Baptiste Kouassi';
    _phoneController.text = '+225 07 12 34 56 78';
    _whatsappController.text = '+225 07 12 34 56 78';
    _emailController.text = 'jb.kouassi@gmail.com';
    _addressController.text = 'Cocody Riviera, Abidjan, Côte d\'Ivoire';
  }

  void _setupChangeListeners() {
    List<TextEditingController> allControllers = [
      _fullNameController, _phoneController, _whatsappController,
      _emailController, _addressController, _waveController,
      _orangeController, _mtnController, _moovController, _customController
    ];

    for (var controller in allControllers) {
      controller.addListener(() {
        if (!_hasChanges) {
          setState(() => _hasChanges = true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.blackSoft,
              size: 20,
            ),
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Informations personnelles',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.blackSoft,
            ),
          ),
          centerTitle: true
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo de profil
                _buildProfilePhoto(),

                const SizedBox(height: 32),

                // Informations personnelles
                _buildPersonalInfoSection(),

                const SizedBox(height: 24),

                // Informations de contact
                _buildContactInfoSection(),

                const SizedBox(height: 24),

                // Adresse
                _buildAddressSection(),

                const SizedBox(height: 24),

                // Méthodes de paiement QR
                _buildPaymentMethodsSection(),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _hasChanges
          ? FloatingActionButton.extended(
        onPressed: _saveChanges,
        backgroundColor: AppColors.primary,
        label: const Text(
          'Enregistrer',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.save_rounded,
          color: Colors.white,
        ),
      )
          : null,
    );
  }

  Widget _buildProfilePhoto() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _selectProfileImage,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: AppColors.primary.withAlpha(200),
                  width: 3,
                ),
              ),
              child: _profileImagePath != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(57),
                child: Image.asset(
                  _profileImagePath!,
                  width: 114,
                  height: 114,
                  fit: BoxFit.cover,
                ),
              )
                  : Icon(
                Icons.person_add_alt_1_rounded,
                size: 50,
                color: AppColors.primary.withAlpha(200),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _selectProfileImage,
            child: Text(
              _profileImagePath != null ? 'Modifier la photo' : 'Ajouter une photo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return _buildSection(
      title: 'Informations personnelles',
      icon: Icons.person_outline_rounded,
      children: [
        _buildTextField(
          controller: _fullNameController,
          label: 'Nom complet',
          hint: 'Entrez votre nom complet',
          icon: Icons.badge_outlined,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Le nom est requis';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return _buildSection(
      title: 'Contact',
      icon: Icons.contact_phone_outlined,
      children: [
        _buildTextField(
          controller: _phoneController,
          label: 'Numéro de téléphone',
          hint: '+225 XX XX XX XX XX',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Le numéro est requis';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _whatsappController,
          label: 'Numéro WhatsApp',
          hint: '+225 XX XX XX XX XX',
          icon: Icons.chat_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _emailController,
          label: 'Email professionnel',
          hint: 'votre.email@exemple.com',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value?.isNotEmpty ?? false) {
              if (!value!.contains('@')) {
                return 'Email invalide';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return _buildSection(
      title: 'Localisation',
      icon: Icons.location_on_outlined,
      children: [
        _buildTextField(
          controller: _addressController,
          label: 'Adresse de l\'immeuble',
          hint: 'Quartier, Commune, Ville, Pays',
          icon: Icons.home_work_outlined,
          maxLines: 3,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'L\'adresse est requise';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPaymentMethodsSection() {
    return _buildSection(
      title: 'Liens QR Code Marchands',
      icon: Icons.qr_code_rounded,
      children: [
        Text(
          'Ajoutez vos liens de paiement pour faciliter les transactions',
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        ...paymentMethods.map((method) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildPaymentMethodField(method),
        )).toList(),
        _buildTextField(
          controller: _customController,
          label: 'Autre méthode de paiement',
          hint: 'Lien vers votre QR code personnalisé',
          icon: Icons.add_link_rounded,
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.primary.withAlpha(150),
              size: 20,
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodField(Map<String, dynamic> method) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: (method['color'] as Color).withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                method['icon'] as IconData,
                color: method['color'] as Color,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              method['name'] as String,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: method['controller'] as TextEditingController,
          decoration: InputDecoration(
            hintText: 'Lien vers votre QR code ${method['name']}',
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.link_rounded,
              color: (method['color'] as Color).withAlpha(150),
              size: 20,
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: method['color'] as Color, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  void _selectProfileImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Changer la photo de profil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageOption(
                    icon: Icons.camera_alt_rounded,
                    label: 'Caméra',
                    onTap: () {
                      Navigator.pop(context);
                      // Simuler la sélection d'image
                      setState(() {
                        _profileImagePath = 'assets/images/profile.jpg';
                        _hasChanges = true;
                      });
                    },
                  ),
                  _buildImageOption(
                    icon: Icons.photo_library_rounded,
                    label: 'Galerie',
                    onTap: () {
                      Navigator.pop(context);
                      // Simuler la sélection d'image
                      setState(() {
                        _profileImagePath = 'assets/images/profile.jpg';
                        _hasChanges = true;
                      });
                    },
                  ),
                  if (_profileImagePath != null)
                    _buildImageOption(
                      icon: Icons.delete_rounded,
                      label: 'Supprimer',
                      color: Colors.red,
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _profileImagePath = null;
                          _hasChanges = true;
                        });
                      },
                    ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (color ?? AppColors.primary).withAlpha(25),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              color: color ?? AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color ?? const Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBack() {
    if (_hasChanges) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Modifications non sauvegardées'),
          content: const Text('Vous avez des modifications non sauvegardées. Voulez-vous les enregistrer avant de quitter ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Ignorer'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _saveChanges();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      // Simuler la sauvegarde
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _hasChanges = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profil mis à jour avec succès'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _waveController.dispose();
    _orangeController.dispose();
    _mtnController.dispose();
    _moovController.dispose();
    _customController.dispose();
    super.dispose();
  }
}