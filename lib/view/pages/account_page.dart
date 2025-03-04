import 'package:dripp/view/pages/barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  // Mock data for ZK proofs (in a real app, this would come from a repository)
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
            // Profile header with NFT picture
            _buildProfileHeader(context),

            // Bio section
            _buildBioSection(),

            // Wallet section with ZK proofs
            _buildZkProofWallet(context),

            // Add new proof button
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
          // NFT profile picture with hexagonal shape
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFFD4AF37),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(
              child: Stack(
                children: [
                  // Placeholder image - in real app, this would be the NFT
                  Container(
                    color: Colors.blueGrey[300],
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // NFT badge overlay
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFFD4AF37),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Jesus of Nazareth',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '@crossbearer',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              color: Color(0xFFD4AF37),
            ),
          ),
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
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Blockchain developer and privacy advocate. Working on decentralized P2P applications with a focus on zero-knowledge proofs for portable identity verification.',
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInterestChip('Blockchain'),
              _buildInterestChip('Zero Knowledge'),
              _buildInterestChip('Privacy'),
              _buildInterestChip('P2P Networks'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInterestChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Color(0xFFD4AF37).withOpacity(0.2),
      labelStyle: TextStyle(
        color: Color(0xFFD4AF37),
      ),
    );
  }

  Widget _buildZkProofWallet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ZK Proof Wallet',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('ZK Proof Wallet'),
                      content: Text(
                        'Your Zero-Knowledge Proofs allow you to verify attributes without revealing the underlying data. These proofs are portable and can be shared with other peers in the network.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Got it'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getProofTypeColor(proof['type']).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getProofTypeIcon(proof['type']),
            color: _getProofTypeColor(proof['type']),
          ),
        ),
        title: Text(
          proof['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Verified: ${proof['date']} • ${proof['type']}',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.qr_code, size: 20),
              onPressed: () {
                _showQrCodeDialog(context, proof);
              },
              tooltip: 'Show QR Code',
            ),
            IconButton(
              icon: Icon(Icons.share_outlined, size: 20),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sharing ${proof['name']} proof'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              tooltip: 'Share Proof',
            ),
          ],
        ),
      ),
    );
  }

  Color _getProofTypeColor(String type) {
    switch (type) {
      case 'Identity':
        return Colors.blue;
      case 'Education':
        return Colors.green;
      case 'Financial':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  IconData _getProofTypeIcon(String type) {
    switch (type) {
      case 'Identity':
        return Icons.fingerprint;
      case 'Education':
        return Icons.school;
      case 'Financial':
        return Icons.attach_money;
      default:
        return Icons.verified_user;
    }
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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                // This would be a real QR code in a production app
                child: Icon(
                  Icons.qr_code_2,
                  size: 150,
                  color: _getProofTypeColor(proof['type']),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'This proof verifies your ${proof['name']} without revealing the underlying data.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sharing ${proof['name']} proof'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Share'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFD971F),
              foregroundColor: const Color(0xFF272822),
            ),
          ),
        ],
      ),
    );
  }
}
