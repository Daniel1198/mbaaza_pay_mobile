import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/colors.dart';
import 'details_paiement_screen.dart';

class ActivitesRecentesScreen extends StatefulWidget {
  const ActivitesRecentesScreen({super.key});

  @override
  State<ActivitesRecentesScreen> createState() => _ActivitesRecentesScreenState();
}

class _ActivitesRecentesScreenState extends State<ActivitesRecentesScreen> {
  // Liste des locataires (vous pouvez remplacer par vos données)
  final List<Map<String, String>> _allLocataires = [
    {'name': 'Aly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Cly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Février'},
    {'name': 'Cly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Février'},
    {'name': 'Cly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Février'},
    {'name': 'Cly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Février'},
    {'name': 'Cly Stéphane', 'date': 'Paiement reçu', 'montant': '20 000', 'section': 'Février'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildLocatairesList()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
        'Activités récentes',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.blackSoft,
        ),
      ),
      centerTitle: true
    );
  }

  Widget _buildLocatairesList() {
    final groupedLocataires = _allLocataires;

    if (groupedLocataires.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, sectionIndex) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Padding(
              padding: EdgeInsets.only(left: 33, bottom: 12, top: 10),
              child: Text(
                "14 Janvier 2025",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyDark,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // Locataires dans cette section
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: groupedLocataires.length,
              itemBuilder: (context, index) =>
                  _buildLocataireItem(_allLocataires[index]),
              separatorBuilder: (context, index) =>
                  Divider(height: 0, color: Colors.grey.shade100),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocataireItem(Map<String, String> locataire) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Text(
        "10:35",
        style: GoogleFonts.figtree(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.greyDark,
        ),
      ),
      tileColor: Colors.white,
      subtitle: Text(
        "de : ${locataire['name']!}",
        style: GoogleFonts.figtree(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
        ),
      ),
      title: Text(
        locataire['date']!,
        style: GoogleFonts.figtree(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.blackSoft,
        ),
      ),
      trailing: Text(
        "${locataire['montant']!} XOF",
        style: GoogleFonts.figtree(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.search_off,
              color: Color(0xFF9CA3AF),
              size: 40,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Aucun locataire trouvé',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Essayez de modifier votre recherche',
            style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }
}
