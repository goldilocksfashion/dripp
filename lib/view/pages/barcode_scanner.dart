import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _scanResult = "Scan a Driver License";
  final MobileScannerController _scannerController = MobileScannerController();

  void processBarcode(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      if (barcode.rawValue != null) {
        setState(() {
          _scanResult = barcode.rawValue!;
        });

        // Simulate sending to Rust (we'll add FFI later)
        Future.delayed(Duration(seconds: 1), () {
          // Return to the previous screen (home page)
          Navigator.of(context).pop();
        });

        break; // Stop after first valid scan
      }
    }
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Driver's License"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Return to home page
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: _scannerController,
              onDetect: processBarcode,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  _scanResult,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Return to home page
                  },
                  child: Text("Cancel Scan"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
