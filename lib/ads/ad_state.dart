import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  late final Future<InitializationStatus> initialization;

  AdState({required this.initialization});

  String get bannerAdUnitId {
    return "ca-app-pub-4608079557029160/9203790846";
  }

  final BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    onAdOpened: (Ad ad) => print('Ad opened.'),
    onAdClosed: (Ad ad) => print('Ad closed.'),
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  BannerAdListener get adListener => _adListener;
}
