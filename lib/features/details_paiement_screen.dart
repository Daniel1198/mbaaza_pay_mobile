import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/colors.dart';

class DetailsPaiementScreen extends StatefulWidget {
  final Map<String, String> paiement;
  const DetailsPaiementScreen({super.key, required this.paiement});

  @override
  State<DetailsPaiementScreen> createState() => _DetailsPaiementScreenState();
}

class _DetailsPaiementScreenState extends State<DetailsPaiementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          title: Text(
                            'Montant versé',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackSoft,
                            ),
                          ),
                          trailing: Text(
                            '20 000 XOF',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          title: Text(
                            'Montant du loyer',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackSoft,
                            ),
                          ),
                          trailing: Text(
                            '75 000 XOF',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyDark,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          title: Text(
                            'Locataire',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackSoft,
                            ),
                          ),
                          trailing: Text(
                            'Aly Stéphane',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyDark,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          title: Text(
                            'Date',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackSoft,
                            ),
                          ),
                          trailing: Text(
                            '07 Janvier 2025',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyDark,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          title: Text(
                            'Montant restant',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackSoft,
                            ),
                          ),
                          trailing: Text(
                            '55 000 XOF',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyDark,
                            ),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          title: Text(
                            'Mois',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackSoft,
                            ),
                          ),
                          trailing: Text(
                            'Janvier',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Nom du locataire
        Text(
          '${widget.paiement['montant'] ?? '0'} XOF',
          style: GoogleFonts.figtree(
            fontSize: 32,
            color: AppColors.blackSoft,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          'Janvier 2025',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildBottomActionButton(
              icon: Icons.download,
              label: 'Télécharger',
              color: AppColors.blackSoft,
              onTap: () {},
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: _buildBottomActionButton(
              icon: Icons.share,
              label: 'Partager',
              color: AppColors.blackSoft,
              onTap: () {},
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.figtree(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
