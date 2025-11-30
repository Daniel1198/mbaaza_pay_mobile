import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mbaaza_pay/features/change_password_screen.dart';
import 'package:mbaaza_pay/features/edit_owner_profile_screen.dart';
import 'package:mbaaza_pay/features/login_screen.dart';
import 'package:mbaaza_pay/features/subscription_pricing_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants/colors.dart';
import '../data/services/auth_service.dart';

class ParametresScreen extends StatefulWidget {
  const ParametresScreen({super.key});

  @override
  State<ParametresScreen> createState() => _ParametresScreenState();
}

class _ParametresScreenState extends State<ParametresScreen> {
  final Auth _auth = Auth();

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
            'Paramètres',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.blackSoft,
            ),
          ),
          centerTitle: true
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => EditOwnerProfileScreen())
              );
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
            ),
            tileColor: Colors.white,
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Informations personnelles', style: GoogleFonts.figtree(fontWeight: FontWeight.w500, color: AppColors.blackSoft),),
          ),
          Divider(height: 0, thickness: 0, indent: 55,),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => SubscriptionPricingScreen())
              );
            },
            tileColor: Colors.white,
            leading: Icon(Icons.credit_card),
            title: Text('Abonnement', style: GoogleFonts.figtree(fontWeight: FontWeight.w500, color: AppColors.blackSoft),),
          ),
          Divider(height: 0, thickness: 0, indent: 55,),
          ListTile(
            onTap: () {
              _sendWhatsApp(context);
            },
            tileColor: Colors.white,
            leading: Icon(Icons.headset_mic_outlined),
            title: Text('Contacter le service client', style: GoogleFonts.figtree(fontWeight: FontWeight.w500, color: AppColors.blackSoft),),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => ChangePasswordScreen())
              );
            },
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            leading: Icon(Icons.password),
            title: Text('Changer mon mot de passe', style: GoogleFonts.figtree(fontWeight: FontWeight.w500, color: AppColors.blackSoft),),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              _showLogoutConfirmation();
            },
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            leading: Icon(Icons.logout, color: Colors.red,),
            title: Text('Se déconnecter', style: GoogleFonts.figtree(fontWeight: FontWeight.w500, color: AppColors.blackSoft),),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.logout,
                size: 60,
                color: Colors.red,
              ),

              const SizedBox(height: 16),

              const Text(
                'Confirmer la déconnexion',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Souhaitez-vous réellement déconnecter votre compte ?',
                textAlign: TextAlign.center,
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
                        'Non',
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
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          try {
                            await _auth.logout();

                            // Redirection vers la page de login
                            if (!mounted) return;
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => LoginScreen()), (route) => false);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vous êtes déconnecté.'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erreur : $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Oui',
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
      )
    );
  }

  void _sendWhatsApp(context) async {
    const telephone = "22579706401";

    final url = Uri.parse(
      "https://wa.me/$telephone",
    );

    if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ouverture de WhatsApp.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("WhatsApp n'est pas installé.")),
      );
    }
  }
}
