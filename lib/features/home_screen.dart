import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mbaaza_pay/core/constants/colors.dart';
import 'package:mbaaza_pay/features/locataires_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec profil
              _buildHeader(),

              const SizedBox(height: 32),

              // Carte des loyers
              _buildBalanceCard(),

              const SizedBox(height: 40),

              // Section Services
              const Text(
                'Services',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 24),

              // Liste des services
              Expanded(
                child: _buildServicesList(),
              ),

              const SizedBox(height: 20),

              // Bottom Navigation
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
}
}

Widget _buildHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E9EA),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Color(0xFF6B7280),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Text(
                'Bienvenue',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withAlpha(8),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.settings_outlined,
          color: Color(0xFF374151),
          size: 20,
        ),
      ),
    ],
  );
}

Widget _buildBalanceCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF06B6D4).withAlpha(40),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Loyers du mois',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.trending_up,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        const Text(
          '856 400 XOF',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reçu',
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '56 400 XOF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'En attente',
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '800 000 XOF',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildServicesList() {
  final services = [
    {
      'title': 'Mes locataires',
      'subtitle': 'Gérez vos locataires',
      'icon': Icons.people_outline,
      'color': const Color(0xFF8B5CF6),
    },
    {
      'title': 'Relevé de paiements',
      'subtitle': 'Gérez vos locataires',
      'icon': Icons.receipt_long_outlined,
      'color': const Color(0xFF10B981),
    },
    {
      'title': 'Quittance',
      'subtitle': 'Gérez vos locataires',
      'icon': Icons.description_outlined,
      'color': const Color(0xFFF59E0B),
    },
  ];

  return ListView.separated(
    itemCount: services.length,
    separatorBuilder: (context, index) => const SizedBox(height: 16),
    itemBuilder: (context, index) {
      final service = services[index];
      return MaterialButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocatairesScreen()));
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1,
            ),
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
                  color: (service['color'] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  service['icon'] as IconData,
                  color: service['color'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      service['subtitle'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFD1D5DB),
                size: 16,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildBottomNavigation() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFFE5E7EB),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF000000).withAlpha(10),
          blurRadius: 20,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(Icons.home_outlined, true),
        _buildNavItem(Icons.access_time_outlined, false),
        _buildNavItem(Icons.headset_mic_outlined, false),
      ],
    ),
  );
}

Widget _buildNavItem(IconData icon, bool isSelected) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isSelected
          ? const Color(0xFF06B6D4).withAlpha(25)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(
      icon,
      color: isSelected
          ? const Color(0xFF06B6D4)
          : const Color(0xFF9CA3AF),
      size: 24,
    ),
  );
}
