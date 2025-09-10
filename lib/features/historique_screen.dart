import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mbaaza_pay/features/details_paiement_screen.dart';

import '../core/constants/colors.dart';
import 'edition_locataire_screen.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key});

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Liste des locataires (vous pouvez remplacer par vos données)
  final List<Map<String, String>> _allLocataires = [
    {'name': 'Aly Stéphane', 'date': '13 Janvier 2025', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': '14 Janvier 2025', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': '15 Janvier 2025', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': '16 Janvier 2025', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': '17 Janvier 2025', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Aly Stéphane', 'date': '22 Janvier 2025', 'montant': '20 000', 'section': 'Janvier'},
    {'name': 'Cly Stéphane', 'date': '05 Février 2025', 'montant': '20 000', 'section': 'Février'},
    {'name': 'Cly Stéphane', 'date': '13 Février 2025', 'montant': '20 000', 'section': 'Février'},
    {'name': 'Cly Stéphane', 'date': '16 Février 2025', 'montant': '20 000', 'section': 'Février'},
    {'name': 'Cly Stéphane', 'date': '22 Février 2025', 'montant': '20 000', 'section': 'Février'},
    {'name': 'Cly Stéphane', 'date': '28 Février 2025', 'montant': '20 000', 'section': 'Février'},
  ];

  List<Map<String, String>> get _filteredLocataires {
    if (_searchQuery.isEmpty) {
      return _allLocataires;
    }
    return _allLocataires
        .where(
          (locataire) => locataire['name']!.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ),
        )
        .toList();
  }

  Map<String, List<Map<String, String>>> get _groupedLocataires {
    final Map<String, List<Map<String, String>>> grouped = {};

    for (final locataire in _filteredLocataires) {
      final section = locataire['section']!;
      if (!grouped.containsKey(section)) {
        grouped[section] = [];
      }
      grouped[section]!.add(locataire);
    }

    // Trier les sections alphabétiquement
    final sortedKeys = grouped.keys.toList()..sort();
    final sortedGrouped = <String, List<Map<String, String>>>{};
    for (final key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!;
    }

    return sortedGrouped;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
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
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildLocatairesList()),
        ],
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
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Paiements',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actionsPadding: EdgeInsets.only(right: 10),
      actions: [
        IconButton(
          icon: const Icon(Icons.add, color: AppColors.white, size: 20),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditionLocataireScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(color: Colors.white),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Recherche',
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_alt_outlined, size: 20, color: AppColors.primary,),
            ),
          ),
          style: const TextStyle(fontSize: 16, color: Color(0xFF1A1A1A)),
        ),
      ),
    );
  }

  Widget _buildLocatairesList() {
    final groupedLocataires = _groupedLocataires;

    if (groupedLocataires.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      itemCount: groupedLocataires.length,
      itemBuilder: (context, sectionIndex) {
        final section = groupedLocataires.keys.elementAt(sectionIndex);
        final locataires = groupedLocataires[section]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Padding(
              padding: EdgeInsets.only(left: 33, bottom: 12, top: 10),
              child: Text(
                section,
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
              itemCount: locataires.length,
              itemBuilder: (context, index) =>
                  _buildLocataireItem(locataires[index]),
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
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsPaiementScreen(paiement: locataire),
          ),
        );
      },
      tileColor: Colors.white,
      subtitle: Text(
        locataire['name']!,
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
        locataire['montant']!,
        style: GoogleFonts.figtree(
          fontSize: 16,
          fontWeight: FontWeight.bold,
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
