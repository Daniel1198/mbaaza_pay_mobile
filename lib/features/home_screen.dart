import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mbaaza_pay/features/activites_recentes_screen.dart';
import 'package:mbaaza_pay/features/historique_screen.dart';
import 'package:mbaaza_pay/features/locataires_screen.dart';
import 'package:mbaaza_pay/features/quittance_screen.dart';

import '../core/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final headerHeight = 80.0; // Hauteur approximative de votre header
    final cardHeight = 220.0; // Hauteur de votre carte balance
    final spacing = 20.0; // Espacement entre header et carte

    // Position du milieu de la carte
    final cardMiddlePosition =
        safeAreaTop + 20 + headerHeight + spacing + (cardHeight / 2);
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: _buildHeader(),
        titleSpacing: 20,
        toolbarHeight: 80,
        elevation: 0,
      ),
      body: SizedBox(
        height: screenHeight,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: cardMiddlePosition -100,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBalanceCard(),
                      SizedBox(height: 20),
                      GridView.count(
                        crossAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LocatairesScreen(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.people,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.primary.withAlpha(
                                    25,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Locataires',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HistoriqueScreen(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.receipt_long,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.primary.withAlpha(
                                    25,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Paiements',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => QuittanceScreen(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.checklist,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.primary.withAlpha(
                                    25,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Suivi loyers',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => LocatairesScreen(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.headset_mic_rounded,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.primary.withAlpha(
                                    25,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Support',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '18',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 48,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white12,
                                        size: 56,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '- ACTIFS -',
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                gradient: AppColors.secondaryGradient,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '3',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 48,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        Icons.block,
                                        color: Colors.white12,
                                        size: 56,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '- INACTIFS -',
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Activités récentes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackSoft,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => ActivitesRecentesScreen())
                                );
                              },
                              icon: Icon(Icons.arrow_right_alt),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      ListView.separated(
                        shrinkWrap: true,
                          itemCount: 6,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, i) => Divider(height: 24, color: Colors.grey.shade100,),
                          itemBuilder: (context, index) {
                            return _buildActivityItem(
                              'Paiement reçu',
                              'Marie Dupont',
                              '125 000 XOF',
                              Icons.check_circle,
                              AppColors.primary,
                            );
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildActivityItem(
    String title, String subtitle, String trailing, IconData icon, Color color) {
  return Row(
    children: [
      Text(
        "10:35",
        style: GoogleFonts.figtree(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.greyDark,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "de : $subtitle",
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
      Text(
        trailing,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    ],
  );
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(Icons.person, color: Color(0xFF6B7280), size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Badge(
                label: Text('En retard'),
                backgroundColor: AppColors.secondary,
              ),
            ],
          ),
        ],
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.settings_outlined,
          color: AppColors.blackSoft,
          size: 20,
        ),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ],
  );
}

Widget _buildBalanceCard() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: AppColors.primaryGradient,
      image: DecorationImage(
        image: AssetImage('assets/images/background-card.png'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.color),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec titre et icône
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOYERS DU MOIS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Décembre 2024',
                    style: TextStyle(
                      color: Colors.white.withAlpha(160),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withAlpha(30),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          // Montant principal
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: const Text(
              '856 400',
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.5,
                height: 1,
              ),
            ),
          ),

          LinearProgressIndicator(
            backgroundColor: Colors.orange.shade300,
            color: Colors.greenAccent,
            value: .2,
          ),

          const SizedBox(height: 15),

          // Statistiques en bas
          Row(
            children: [
              // Reçu
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'REÇU',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '56 400',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // En attente
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.orangeAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'EN ATTENTE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '800 000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
