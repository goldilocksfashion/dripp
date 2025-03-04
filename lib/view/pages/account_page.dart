import 'package:dripp/view/pages/barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  final int drippCoinBalance = 3250; // Mock Dripp Coin balance

  // Mock ZK Proofs (in a real app, fetch from storage/backend)
  final List<Map<String, dynamic>> zkProofs = [
    {'name': 'Age Verification', 'date': '2025-02-15', 'type': 'Identity'},
    {'name': 'College Degree', 'date': '2025-02-10', 'type': 'Education'},
    {'name': 'Driver License', 'date': '2025-01-25', 'type': 'Identity'},
    {'name': 'Income Proof', 'date': '2025-01-15', 'type': 'Financial'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context),
            _buildBioSection(),
            _buildDrippCoinWallet(context),
            _buildZkProofWallet(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => BarcodeScannerScreen()),
                  );
                },
                icon: Icon(Icons.qr_code_scanner),
                label: Text('Scan New ZK Proof'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFD971F),
                  foregroundColor: const Color(0xFF272822),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ✅ Profile Header
  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF272822).withOpacity(0.9),
            Color(0xFF272822).withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFD4AF37), width: 4),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
              ],
            ),
            child: ClipOval(
              child: Center(
                child: Icon(Icons.person, size: 80, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text('Jesus of Nazareth',
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text('@crossbearer',
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 16, color: Color(0xFFD4AF37))),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatColumn('154', 'Connections'),
              _buildStatColumn('28', 'Groups'),
              _buildStatColumn('4', 'ZK Proofs'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Text(count,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }

  // ✅ Bio Section
  Widget _buildBioSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About',
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'Blockchain developer and privacy advocate. Working on decentralized P2P applications with a focus on zero-knowledge proofs for portable identity verification.',
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
  }

  // ✅ Dripp Coin Wallet
  Widget _buildDrippCoinWallet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dripp Coins Wallet 💰',
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: ListTile(
              leading: Icon(Icons.monetization_on,
                  color: Color(0xFFD4AF37), size: 36),
              title: Text('Dripp Coin Balance',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('$drippCoinBalance Coins',
                  style: TextStyle(fontSize: 16, color: Colors.green)),
              trailing: ElevatedButton(
                onPressed: () {},
                child: Text("Use Coins"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD971F),
                    foregroundColor: Color(0xFF272822)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ ZK Proof Wallet
  Widget _buildZkProofWallet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ZK Proof Wallet 🔒',
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...zkProofs.map((proof) => _buildProofCard(proof, context)).toList(),
        ],
      ),
    );
  }

  Widget _buildProofCard(Map<String, dynamic> proof, BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.verified, color: Colors.blue),
        title:
            Text(proof['name'], style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Verified: ${proof['date']} • ${proof['type']}',
            style: TextStyle(fontSize: 12)),
        trailing: IconButton(
          icon: Icon(Icons.qr_code, size: 20),
          onPressed: () => _showQrCodeDialog(context, proof),
        ),
      ),
    );
  }

  void _showQrCodeDialog(BuildContext context, Map<String, dynamic> proof) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ZK Proof: ${proof['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                  child: Icon(Icons.qr_code_2, size: 150, color: Colors.blue)),
            ),
            SizedBox(height: 16),
            Text(
                'This proof verifies your ${proof['name']} without revealing the underlying data.',
                textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close')),
        ],
      ),
    );
  }
}
