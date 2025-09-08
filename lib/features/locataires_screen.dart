import 'package:flutter/material.dart';
import 'package:mbaaza_pay/core/constants/colors.dart';
import 'package:mbaaza_pay/features/details_locataire_screen.dart';
import 'package:mbaaza_pay/features/edition_locataire_screen.dart';

class LocatairesScreen extends StatefulWidget {
  const LocatairesScreen({super.key});

  @override
  State<LocatairesScreen> createState() => _LocatairesScreenState();
}

class _LocatairesScreenState extends State<LocatairesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Liste des locataires (vous pouvez remplacer par vos données)
  final List<Map<String, String>> _allLocataires = [
    {'name': 'Aly Stéphane', 'section': 'A'},
    {'name': 'Aly Stéphane', 'section': 'A'},
    {'name': 'Aly Stéphane', 'section': 'A'},
    {'name': 'Aly Stéphane', 'section': 'A'},
    {'name': 'Aly Stéphane', 'section': 'A'},
    {'name': 'Aly Stéphane', 'section': 'A'},
    {'name': 'Cly Stéphane', 'section': 'C'},
    {'name': 'Cly Stéphane', 'section': 'C'},
    {'name': 'Cly Stéphane', 'section': 'C'},
    {'name': 'Cly Stéphane', 'section': 'C'},
    {'name': 'Cly Stéphane', 'section': 'C'},
  ];

  List<Map<String, String>> get _filteredLocataires {
    if (_searchQuery.isEmpty) {
      return _allLocataires;
    }
    return _allLocataires
        .where((locataire) => locataire['name']!
        .toLowerCase()
        .contains(_searchQuery.toLowerCase()))
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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildLocatairesList(),
          ),
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
      title: const Text(
        'Mes locataires',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1A1A),
        ),
      ),
      centerTitle: true,
      actionsPadding: EdgeInsets.only(right: 10),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add,
            color: AppColors.blackSoft,
            size: 20,
          ),
          style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              )
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditionLocataireScreen()));
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Recherche',
          hintStyle: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF9CA3AF),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF1A1A1A),
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
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      itemCount: groupedLocataires.length,
      itemBuilder: (context, sectionIndex) {
        final section = groupedLocataires.keys.elementAt(sectionIndex);
        final locataires = groupedLocataires[section]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Padding(
              padding: EdgeInsets.only(
                left: 4,
                bottom: 12,
                top: sectionIndex == 0 ? 0 : 32,
              ),
              child: Text(
                section,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // Locataires dans cette section
            ...locataires.asMap().entries.map((entry) {
              final index = entry.key;
              final locataire = entry.value;

              return Container(
                margin: EdgeInsets.only(
                  bottom: index == locataires.length - 1 ? 0 : 12,
                ),
                child: _buildLocataireItem(locataire),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildLocataireItem(Map<String, String> locataire) {
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
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF06B6D4).withAlpha(25),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                locataire['name']!.substring(0, 1),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF06B6D4),
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Nom
          Expanded(
            child: Text(
              locataire['name']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),

          // Bouton d'action
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DetailsLocataireScreen(locataire: locataire))
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.more_horiz,
                color: Color(0xFF6B7280),
                size: 20,
              ),
            ),
          ),
        ],
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
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddLocataireDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Ajouter un locataire',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          content: const Text(
            'Cette fonctionnalité sera bientôt disponible.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF06B6D4),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}