class Seed {
  String seedName = '';
  String seedImage = '';
  String seedOG = '';
  String availability = '';
  String shopName = '';
  List flowerImage = [];
  String description = '';
  bool fav = false;
  int cart = 0;
  bool checkout = false;
  int trackId = 0;
  Seed(
      {this.seedName,
      this.seedImage,
      this.seedOG,
      this.availability,
      this.shopName,
      this.fav,
      this.description,
      this.cart,
      this.checkout,
      this.trackId,
      this.flowerImage});
}
