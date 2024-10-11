class Order {
  String title;
  String date;
  String status;
  String imgUrl;

  Order(this.title, this.date, this.imgUrl, this.status);

  // Sample data
  static List<Order> getOrderItems() {
    return [
      Order("KFC", "Today", "assets/homeImg/home_refer.png", "Ready to pickup"),
      Order("Café Coffee Day", "Today", "assets/homeImg/home_refer.png",
          "Preparing"),
      Order("McDonald's", "Yesterday", "assets/homeImg/home_refer.png",
          "Delivered"),
      Order("Domino's Pizza", "Last week", "assets/homeImg/home_refer.png",
          "Delivered"),
    ];
  }
}
