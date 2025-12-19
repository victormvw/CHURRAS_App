import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const ChurrasApp());
}

class ChurrasApp extends StatelessWidget {
  const ChurrasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Churrasco',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
          secondary: Colors.redAccent,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Inputs
  double _men = 1;
  double _women = 1;
  double _children = 1;

  // Results
  double _meatKg = 0;
  double _beerPacks = 0;
  double _sodaBottles = 0;
  bool _calculated = false;

  // AdMob
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;
  InterstitialAd? _interstitialAd;

  // Test IDs provided by user
  final String _bannerAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3139392062864830/8040306305'
      : 'ca-app-pub-3139392062864830/8040306305'; // iOS Test ID fallback

  final String _interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3139392062864830/8997971239'
      : 'ca-app-pub-3139392062864830/8997971239'; // iOS Test ID fallback

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
    _loadInterstitialAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd?.load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _loadInterstitialAd(); // Reload for next time
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              _loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (err) {
          debugPrint('InterstitialAd failed to load: $err');
        },
      ),
    );
  }

  void _calculate() {
    // Show Interstitial Ad if ready
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null; // Clear reference so we don't show same ad twice
    }

    // Logic:
    // Men: 550g, Women: 350g, Children: 150g
    // + 10% margin
    double totalMeatGrams = (_men * 550) + (_women * 350) + (_children * 150);
    double totalMeatWithMargin = totalMeatGrams * 1.10;

    // Beer: Adults only. Assumption: 4 cans (350ml) per adult.
    // 1 Pack = 12 cans.
    double totalBeerCans = (_men + _women) * 4;

    // Soda: Everyone. Assumption: 500ml per person.
    // 1 Bottle = 2L (2000ml).
    double totalSodaMl = (_men + _women + _children) * 500;

    setState(() {
      _meatKg = totalMeatWithMargin / 1000;
      _beerPacks = totalBeerCans / 12;
      _sodaBottles = totalSodaMl / 2000;
      _calculated = true;
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora de Churrasco',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Image or Icon
                  const Center(
                    child: Icon(
                      Icons.local_fire_department,
                      size: 80,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Inputs Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildSlider("Homens", _men,
                              (val) => setState(() => _men = val)),
                          _buildSlider("Mulheres", _women,
                              (val) => setState(() => _women = val)),
                          _buildSlider("Crianças", _children,
                              (val) => setState(() => _children = val)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Calculate Button
                  ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Calcular'),
                  ),

                  const SizedBox(height: 30),

                  // Results
                  if (_calculated)
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Text(
                              "Resultado (com 10% de margem)",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            _buildResultRow(Icons.restaurant, "Carne",
                                "${_meatKg.toStringAsFixed(1)} KG"),
                            _buildResultRow(Icons.sports_bar, "Cerveja",
                                "${_beerPacks.ceil()} Fardos (12 latas)"),
                            _buildResultRow(Icons.local_drink, "Refrigerante",
                                "${_sodaBottles.ceil()} Garrafas (2L)"),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // AdMob Banner Area
          if (_isBannerAdReady)
            SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            )
          else
            Container(
              height: 50,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Text(
                "Carregando Anúncio...",
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSlider(
      String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text(value.toInt().toString(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange)),
          ],
        ),
        Slider(
          value: value,
          min: 0,
          max: 50,
          divisions: 50,
          activeColor: Colors.deepOrange,
          inactiveColor: Colors.orange[100],
          label: value.toInt().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildResultRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange, size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
