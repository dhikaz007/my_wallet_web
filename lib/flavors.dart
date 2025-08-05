enum Flavor { dev, prod }

class FlavorMode {
  static late Flavor appFlavor;
  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'My Wallet Dev';
      case Flavor.prod:
        return 'My Wallet';
    }
  }
}
