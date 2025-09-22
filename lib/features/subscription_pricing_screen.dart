import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class SubscriptionPricingScreen extends StatefulWidget {
  const SubscriptionPricingScreen({super.key});

  @override
  State<SubscriptionPricingScreen> createState() => _SubscriptionPricingScreenState();
}

class _SubscriptionPricingScreenState extends State<SubscriptionPricingScreen> {
  int selectedPlanIndex = 1; // Par défaut sur trimestre

  final List<Map<String, dynamic>> plans = [
    {
      'period': 'Mensuel',
      'duration': '1 mois',
      'price': 2500,
      'originalPrice': null,
      'discount': null,
      'popular': false,
      'description': 'Parfait pour tester',
      'color': const Color(0xFF6B7280),
    },
    {
      'period': 'Trimestriel',
      'duration': '3 mois',
      'price': 6000,
      'originalPrice': 7500,
      'discount': '20% d\'économie',
      'popular': true,
      'description': 'Le plus populaire',
      'color': const Color(0xFF10B981),
    },
    {
      'period': 'Annuel',
      'duration': '12 mois',
      'price': 20000,
      'originalPrice': 30000,
      'discount': '33% d\'économie',
      'popular': false,
      'description': 'Meilleure valeur',
      'color': const Color(0xFF8B5CF6),
    },
  ];

  final List<String> features = [
    'Gestion illimitée de locataires',
    'Génération de quittances PDF',
    'Suivi des paiements en temps réel',
    'Rappels automatiques',
    'Statistiques avancées',
    'Support prioritaire',
    'Sauvegarde cloud',
    'Export des données',
  ];

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
            'Abonnement',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.blackSoft,
            ),
          ),
          centerTitle: true
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec description
              _buildHeader(),

              const SizedBox(height: 20),

              // Plans de tarification
              _buildPricingPlans(),

              const SizedBox(height: 32),

              // Fonctionnalités incluses
              _buildFeatures(),

              const SizedBox(height: 32),

              // Bouton de confirmation
              _buildSubscribeButton(),

              const SizedBox(height: 16),

              // Note légale
              _buildLegalNote(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'MBaazaPay Premium',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Débloquez toutes les fonctionnalités et gérez vos propriétés sans limite',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(180),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingPlans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choisir votre plan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.blackSoft,
          ),
        ),
        const SizedBox(height: 16),
        ...plans.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> plan = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildPlanCard(plan, index),
          );
        }),
      ],
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan, int index) {
    bool isSelected = selectedPlanIndex == index;
    bool isPopular = plan['popular'] as bool;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlanIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primary : Colors.transparent,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primary.withAlpha(40)
                  : Colors.black.withAlpha(0),
              blurRadius: isSelected ? 15 : 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Indicateur de sélection
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : const Color(0xFFD1D5DB),
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      )
                          : null,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan['period'] as String,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? AppColors.primary
                                  : const Color(0xFF1F2937),
                            ),
                          ),
                          Text(
                            plan['description'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Prix
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (plan['originalPrice'] != null)
                          Text(
                            '${plan['originalPrice']} XOF',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF9CA3AF),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Text(
                          '${plan['price']} XOF',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: isSelected
                                ? AppColors.primary
                                : const Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          'locataire / ${plan['duration']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                if (plan['discount'] != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (plan['color'] as Color).withAlpha(25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      plan['discount'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: plan['color'] as Color,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatures() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fonctionnalités incluses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(25),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    feature,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4B5563),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
    final selectedPlan = plans[selectedPlanIndex];

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: MaterialButton(
        onPressed: () {
          // Action d'abonnement
          _showSubscriptionConfirmation();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.credit_card_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'S\'abonner - ${selectedPlan['price']} XOF',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalNote() {
    return Text(
      'En vous abonnant, vous acceptez nos conditions d\'utilisation. '
          'L\'abonnement se renouvelle automatiquement. '
          'Vous pouvez annuler à tout moment depuis les paramètres.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: const Color(0xFF9CA3AF),
        height: 1.4,
      ),
    );
  }

  void _showSubscriptionConfirmation() {
    final selectedPlan = plans[selectedPlanIndex];

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
              const Icon(
                Icons.check_circle_rounded,
                size: 60,
                color: Colors.green,
              ),

              const SizedBox(height: 16),

              const Text(
                'Confirmer l\'abonnement',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Plan ${selectedPlan['period']} - ${selectedPlan['price']} XOF',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () => Navigator.pop(context),
                      height: 48,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFFE5E7EB)),
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Traiter le paiement
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Confirmer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}