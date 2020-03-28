class Product {
  String title;
  int originalPrice;
  int currentPrice;
  String changeInPer;
  String productUrl;
  int productRating;

  Product(
      {this.title,
      this.originalPrice,
      this.currentPrice,
      this.changeInPer,
      this.productUrl,
      this.productRating});
}

List<Product> products = [
  Product(
      changeInPer: "50.0",
      currentPrice: 7999,
      originalPrice: 5999,
      productRating: 4,
      productUrl: "https://google.com",
      title: "Product 1"),
  Product(
      changeInPer: "50.0",
      currentPrice: 4999,
      originalPrice: 6999,
      productRating: 4,
      productUrl: "https://google.com",
      title: "Product 2"),
  Product(
      changeInPer: "50.0",
      currentPrice: 4999,
      originalPrice: 7799,
      productRating: 4,
      productUrl: "https://google.com",
      title: "Product 3"),
  Product(
      changeInPer: "50.0",
      currentPrice: 4999,
      originalPrice: 5599,
      productRating: 4,
      productUrl: "https://google.com",
      title: "Product 4"),
  Product(
      changeInPer: "50.0",
      currentPrice: 8999,
      originalPrice: 5999,
      productRating: 4,
      productUrl: "https://google.com",
      title: "Product 5"),
];
