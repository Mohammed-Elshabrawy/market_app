class FavoriteProducts {
  String? id;
  String? forUser;
  String? createdAt;
  String? forProduct;
  bool? isFavorite;

  FavoriteProducts({
    this.id,
    this.forUser,
    this.createdAt,
    this.forProduct,
    this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["for_user"] = forUser;
    map["created_at"] = createdAt;
    map["for_product"] = forProduct;
    map["is_favorite"] = isFavorite;
    return map;
  }

  FavoriteProducts.fromJson(dynamic json) {
    id = json["id"];
    forUser = json["for_user"];
    createdAt = json["created_at"];
    forProduct = json["for_product"];
    isFavorite = json["is_favorite"];
  }
}

class Purchased {
  String? id;
  String? forUser;
  bool? isBought;
  String? createdAt;
  String? forProduct;

  Purchased({
    this.id,
    this.forUser,
    this.isBought,
    this.createdAt,
    this.forProduct,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["for_user"] = forUser;
    map["is_bought"] = isBought;
    map["created_at"] = createdAt;
    map["for_product"] = forProduct;
    return map;
  }

  Purchased.fromJson(dynamic json) {
    id = json["id"];
    forUser = json["for_user"];
    isBought = json["is_bought"];
    createdAt = json["created_at"];
    forProduct = json["for_product"];
  }
}

class ProductModel {
  String? productId;
  String? createdAt;
  String? productName;
  String? price;
  String? oldPrice;
  String? sale;
  String? description;
  String? category;
  String? imageUrl;
  List<FavoriteProducts>? favoriteProductsList;
  List<Purchased>? purchasedList;

  ProductModel({
    this.productId,
    this.createdAt,
    this.productName,
    this.price,
    this.oldPrice,
    this.sale,
    this.description,
    this.category,
    this.imageUrl,
    this.favoriteProductsList,
    this.purchasedList,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["product_id"] = productId;
    map["created_at"] = createdAt;
    map["product_name"] = productName;
    map["price"] = price;
    map["old_price"] = oldPrice;
    map["sale"] = sale;
    map["description"] = description;
    map["category"] = category;
    map["image_url"] = imageUrl;
    if (favoriteProductsList != null) {
      map["favorite_products"] = favoriteProductsList
          ?.map((v) => v.toJson())
          .toList();
    }
    if (purchasedList != null) {
      map["purchased"] = purchasedList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  ProductModel.fromJson(dynamic json) {
    productId = json["product_id"];
    createdAt = json["created_at"];
    productName = json["product_name"];
    price = json["price"];
    oldPrice = json["old_price"];
    sale = json["sale"];
    description = json["description"];
    category = json["category"];
    imageUrl = json["image_url"];
    if (json["favorite_products"] != null) {
      favoriteProductsList = [];
      json["favorite_products"].forEach((v) {
        favoriteProductsList?.add(FavoriteProducts.fromJson(v));
      });
    }
    if (json["purchased"] != null) {
      purchasedList = [];
      json["purchased"].forEach((v) {
        purchasedList?.add(Purchased.fromJson(v));
      });
    }
  }
}
