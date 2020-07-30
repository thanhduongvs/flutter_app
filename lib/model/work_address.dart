class WorkAddress {
  final int id;
  final int cityId;
  final String city;
  final int districtId;
  final String district;
  final String address;
  final String latitude;
  final String longitude;

  WorkAddress({
    this.id, this.cityId, this.city, this.districtId,
    this.district, this.address, this. latitude, this.longitude
  });

  factory WorkAddress.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;
    return WorkAddress(
      id: json['id'],
      cityId: json['thanhPhoID'],
      city: json['thanhPho'],
      districtId: json['quanHuyenID'],
      district: json['quanHuyen'],
      address: json['diaChi'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}