class user_info {
  String image;
  String name;
  user_info(this.image, this.name);
  factory user_info.fromJson(dynamic json) {
    return user_info(json['Name'] as String, json['Image'] as String);
  }
  @override
  String v_stroku_image() {
    return '{${this.image} }';
  }

  String v_stroku_name() {
    return '{${this.name} }';
  }
}