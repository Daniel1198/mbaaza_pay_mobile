import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mbaaza_pay/core/constants/colors.dart';
import 'package:mbaaza_pay/data/models/locataire.dart';
import 'package:mbaaza_pay/features/details_locataire_screen.dart';
import 'package:mbaaza_pay/features/edition_locataire_screen.dart';
import '../data/services/locataire_service.dart';

class LocatairesScreen extends StatefulWidget {
  const LocatairesScreen({super.key});

  @override
  State<LocatairesScreen> createState() => _LocatairesScreenState();
}

class _LocatairesScreenState extends State<LocatairesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final LocataireService _locataireService = LocataireService();
  String _searchQuery = '';
  List<Locataire> _allLocataires = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadLocataires();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  Future _loadLocataires() async {
    try {
      final List<Locataire> data = await _locataireService.getLocataires();
        setState(() {
          _allLocataires = data;
          _loading = false;
          _error = null;
        });
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Locataire> get _filteredLocataires {
    if (_searchQuery.isEmpty) {
      return _allLocataires;
    }

    final query = _searchQuery.toLowerCase().trim();
    return _allLocataires.where((locataire) {
      final nom = locataire.nomComplet.toLowerCase();
      return nom.contains(query);
    }).toList();
  }

  Map<String, List<Locataire>> get _groupedLocataires {
    final Map<String, List<Locataire>> grouped = {};

    for (final locataire in _filteredLocataires) {
      final nom = locataire.nomComplet;
      final section = nom.isNotEmpty ? nom[0].toUpperCase() : '#';

      grouped.putIfAbsent(section, () => []);
      grouped[section]!.add(locataire);
    }

    // Tri des sections et des locataires
    final sortedKeys = grouped.keys.toList()..sort();
    final sortedGrouped = <String, List<Locataire>>{};

    for (final key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!
        ..sort((a, b) => (a.nomComplet).compareTo(b.nomComplet));
    }

    return sortedGrouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _buildErrorState()
          : Column(
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
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Mes locataires',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add, color: AppColors.white, size: 28),
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EditionLocataireScreen(),
              ),
            );

            // Recharger la liste si un locataire a été ajouté
            if (result == true) {
              _loadLocataires();
            }
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Rechercher un locataire',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 22),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, size: 20),
            onPressed: () {
              _searchController.clear();
            },
          )
              : null,
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: groupedLocataires.length,
      itemBuilder: (context, sectionIndex) {
        final section = groupedLocataires.keys.elementAt(sectionIndex);
        final locataires = groupedLocataires[section]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 16, bottom: 8),
              color: Colors.grey.shade50,
              width: double.infinity,
              child: Text(
                section,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: locataires.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey.shade200,
                indent: 72,
              ),
              itemBuilder: (context, index) => _buildLocataireItem(locataires[index]),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocataireItem(Locataire locataire) {
    final name = locataire.nomComplet;
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      onTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsLocataireScreen(locataire: locataire),
          ),
        );

        // Recharger si des modifications ont été faites
        if (result == true) {
          _loadLocataires();
        }
      },
      tileColor: Colors.white,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary,
        radius: 24,
        child: Text(
          initial,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: Text(
        name,
        style: GoogleFonts.figtree(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1A1A1A),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey.shade400,
        size: 24,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isEmpty ? Icons.people_outline : Icons.search_off,
              color: Colors.grey.shade300,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              _searchQuery.isEmpty
                  ? 'Aucun locataire'
                  : 'Aucun résultat trouvé',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isEmpty
                  ? 'Ajoutez votre premier locataire'
                  : 'Essayez une autre recherche',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            if (_searchQuery.isEmpty) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditionLocataireScreen(),
                    ),
                  );
                  if (result == true) {
                    _loadLocataires();
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Ajouter un locataire'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade300, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Erreur de chargement',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? 'Une erreur est survenue',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadLocataires,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}