import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdUnifiedBanner extends StatefulWidget {
  final double height;
  const AdUnifiedBanner({super.key, this.height = 100});

  @override
  State<AdUnifiedBanner> createState() => _AdUnifiedBannerState();
}

class _AdUnifiedBannerState extends State<AdUnifiedBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      return;
    }

    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() => _isLoaded = true),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          setState(() => _isLoaded = false);
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container(
        height: 100,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24, width: 1),
        ),
        child: const Text(
          "Рекламный баннер (демо — Web)",
          style: TextStyle(color: Colors.white54, fontSize: 18),
        ),
      );
    }

    if (!_isLoaded) return const SizedBox(height: 0);

    return SizedBox(
      height: 60,
      child: AdWidget(ad: _bannerAd!),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
