import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/colors.dart';

class QuittanceScreen extends StatefulWidget {
  const QuittanceScreen({super.key});

  @override
  State<QuittanceScreen> createState() => _QuittanceScreenState();
}

class _QuittanceScreenState extends State<QuittanceScreen> {
  int selectedYear = DateTime.now().year;

  // Map pour stocker l'état des paiements (mois -> payé ou non)
  Map<int, bool> paymentStatus = {};

  final List<String> months = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre',
  ];

  @override
  void initState() {
    super.initState();
    // Initialiser tous les mois comme non payés
    for (int i = 1; i <= 12; i++) {
      paymentStatus[i] = false;
    }
  }

  void togglePaymentStatus(int month) {
    setState(() {
      paymentStatus[month] = !paymentStatus[month]!;
    });
  }

  int get paidMonthsCount {
    return paymentStatus.values.where((paid) => paid).length;
  }

  double get yearProgress {
    return paidMonthsCount / 12;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Suivi des loyers',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white.withAlpha(25),
            ),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                useSafeArea: true,
                context: context,
                builder: (builder) => _buildYearSelection(),
              );
            },
            child: Text('2023', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              trailing: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.white,
                      useSafeArea: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (builder) => _buildLocataireSelection()
                  );
                },
                icon: Icon(Icons.arrow_drop_down),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              tileColor: Colors.white,
              title: Text(
                'Aly Stéphane',
                style: GoogleFonts.figtree(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildYearStats(),
                    _buildMonthsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearStats() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progression $selectedYear',
                      style: GoogleFonts.figtree(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$paidMonthsCount / 12 mois',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(25),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      '${(yearProgress * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Barre de progression
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: yearProgress,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Mois de l\'année',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.greyDark.withAlpha(200),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: months.length,
          separatorBuilder: (context, index) => Divider(height: 0, color: Colors.grey.shade100,),
          itemBuilder: (context, index) {
            return _buildMonthCard(index + 1, months[index]);
          },
        ),
      ],
    );
  }

  Widget _buildMonthCard(int monthNumber, String monthName) {
    bool isPaid = paymentStatus[monthNumber] ?? false;

    return ListTile(
      tileColor: Colors.white,
      leading: Icon(
        isPaid
            ? Icons.check_circle_rounded
            : Icons.calendar_month_rounded,
        color: isPaid ? Colors.green : const Color(0xFF9CA3AF),
        size: 24,
      ),
      title: Text(
        monthName,
        style: GoogleFonts.figtree(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isPaid ? Colors.green : AppColors.blackSoft,
        ),
      ),
      subtitle: Text(
        isPaid ? 'Loyer payé' : 'En attente de paiement',
        style: TextStyle(
          fontSize: 14,
          color: isPaid
              ? AppColors.primary
              : AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: MaterialButton(
        onPressed: () => togglePaymentStatus(monthNumber),
        minWidth: 0,
        elevation: 0,
        color: isPaid
            ? Colors.red.withAlpha(25)
            : Colors.green.withAlpha(25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isPaid
                ? Colors.red.withAlpha(100)
                : Colors.green.withAlpha(100),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          isPaid ? 'Annuler' : 'Payer',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isPaid ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _buildYearSelection() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Sélectionner l'année",
              style: TextStyle(
                color: AppColors.greyDark,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(maxHeight: 200),
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              itemCount: 12,
              itemBuilder: (itemBuilder, index) {
                return MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  color: Colors.grey.shade100,
                  child: Text(
                    '2025',
                    style: GoogleFonts.figtree(fontWeight: FontWeight.w600),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocataireSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Sélectionner le locataire",
            style: TextStyle(
              color: AppColors.greyDark,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Recherche',
              prefixIcon: Icon(Icons.search),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: Colors.grey.shade100
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (itemBuilder, index) {
              return ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                title: Text(
                  'John Doe',
                  style: GoogleFonts.figtree(fontWeight: FontWeight.w500),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
