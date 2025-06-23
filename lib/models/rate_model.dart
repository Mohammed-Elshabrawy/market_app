class RateModel {
  String? id;
  String? createdAt;
  int? rate;
  String? forUser;
  String? forProduct;

  RateModel({
    this.id,
    this.createdAt,
    this.rate,
    this.forUser,
    this.forProduct,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["created_at"] = createdAt;
    map["rate"] = rate;
    map["for_user"] = forUser;
    map["for_product"] = forProduct;
    return map;
  }

  RateModel.fromJson(dynamic json) {
    id = json["id"];
    createdAt = json["created_at"];
    rate = json["rate"];
    forUser = json["for_user"];
    forProduct = json["for_product"];
  }
}
