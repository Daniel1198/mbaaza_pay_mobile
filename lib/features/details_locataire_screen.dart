import 'package:flutter/material.dart';
import 'package:mbaaza_pay/features/edition_locataire_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants/colors.dart';

class DetailsLocataireScreen extends StatefulWidget {
  final Map<String, String> locataire;

  const DetailsLocataireScreen({
    super.key,
    required this.locataire,
  });

  @override
  State<DetailsLocataireScreen> createState() => _DetailsLocataireScreenState();
}

class _DetailsLocataireScreenState extends State<DetailsLocataireScreen> {
  bool _isBlocked = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isBlocked = widget.locataire['isBlocked'] == 'true';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 32),
                  _buildContactInfo(),
                  const SizedBox(height: 1),
                  _buildLocationInfo(),
                  const SizedBox(height: 1),
                  _buildRentInfo(),
                  const SizedBox(height: 32),
                  _buildHistoryButton(),
                ],
              ),
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF374151),
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
        'Détails',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.blackSoft,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nom du locataire
        Text(
          widget.locataire['nom'] ?? 'Nom inconnu',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.blackSoft,
            letterSpacing: -0.5,
          ),
        ),

        // Téléphone avec actions
        Row(
          children: [
            const Text(
              'Téléphone',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.locataire['telephone'] ?? 'Non renseigné',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.blackSoft,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),

            // Bouton appeler
            _buildActionButton(
              icon: Icons.phone,
              color: const Color(0xFF10B981),
              onTap: _makePhoneCall,
            ),

            const SizedBox(width: 12),

            // Bouton message
            _buildActionButton(
              icon: Icons.chat_bubble_outline,
              color: const Color(0xFF06B6D4),
              onTap: _sendSMS,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return MaterialButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      minWidth: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return _buildInfoCard(
      icon: Icons.email_outlined,
      iconColor: AppColors.secondary,
      title: 'E-mail',
      subtitle: widget.locataire['email']?.isNotEmpty == true
          ? widget.locataire['email']!
          : 'nom@domain',
      isPlaceholder: widget.locataire['email']?.isEmpty != false,
    );
  }

  Widget _buildLocationInfo() {
    return _buildInfoCard(
      icon: Icons.location_on_outlined,
      iconColor: AppColors.secondary,
      title: 'Adresse exacte du logement',
      subtitle: widget.locataire['adresse'] ?? 'Yopougon, Cité verte',
    );
  }

  Widget _buildRentInfo() {
    final montant = widget.locataire['montant'] ?? '25 000';
    return _buildInfoCard(
      icon: Icons.monetization_on_outlined,
      iconColor: AppColors.secondary,
      title: 'Montant du loyer',
      subtitle: '$montant F CFA',
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool isPlaceholder = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: isPlaceholder
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _showPaymentHistory,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0
        ),
        child: const Text(
          'Historique des paiements',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildBottomActionButton(
              icon: _isBlocked ? Icons.lock_open_outlined : Icons.block_outlined,
              label: _isBlocked ? 'Débloquer' : 'Bloquer',
              color: AppColors.blackSoft,
              onTap: _toggleBlockStatus,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: _buildBottomActionButton(
              icon: Icons.edit_outlined,
              label: 'Modifier',
              color: AppColors.blackSoft,
              onTap: _editLocataire,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: _buildBottomActionButton(
              icon: Icons.delete_outline,
              label: 'Supprimer',
              color: AppColors.blackSoft,
              onTap: _deleteLocataire,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      onPressed: _isLoading ? null : onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Actions methods
  void _makePhoneCall() async {
    final telephone = widget.locataire['telephone'];
    if (telephone != null && telephone.isNotEmpty) {
      final uri = Uri.parse('tel:$telephone');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        _showErrorSnackBar('Impossible de passer l\'appel');
      }
    }
  }

  void _sendSMS() async {
    final telephone = widget.locataire['telephone'];
    if (telephone != null && telephone.isNotEmpty) {
      final uri = Uri.parse('sms:$telephone');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        _showErrorSnackBar('Impossible d\'envoyer le SMS');
      }
    }
  }

  void _showPaymentHistory() {
    // Navigation vers l'historique des paiements
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Historique des paiements'),
        content: const Text('Cette fonctionnalité sera bientôt disponible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleBlockStatus() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simuler une requête réseau
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _isBlocked = !_isBlocked;
      });

      _showSuccessSnackBar(
          _isBlocked
              ? 'Locataire bloqué avec succès'
              : 'Locataire débloqué avec succès'
      );
    } catch (e) {
      _showErrorSnackBar('Erreur lors de l\'opération');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _editLocataire() {
    // Navigation vers la page d'édition
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditionLocataireScreen()));
  }

  void _deleteLocataire() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Supprimer le locataire',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer ${widget.locataire['nom']} ? Cette action est irréversible.',
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Annuler',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
          ),
          ElevatedButton(
            onPressed: _confirmDelete,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
            ),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete() async {
    Navigator.of(context).pop(); // Fermer le dialog

    setState(() {
      _isLoading = true;
    });

    try {
      // Simuler une requête réseau
      await Future.delayed(const Duration(seconds: 1));

      _showSuccessSnackBar('Locataire supprimé avec succès');

      // Retourner à la page précédente après un délai
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pop(true); // true indique que le locataire a été supprimé
        }
      });
    } catch (e) {
      _showErrorSnackBar('Erreur lors de la suppression');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }
}