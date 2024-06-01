class CarDataModel{
 final int id;
  final String name;
  final String type;
  final String imageName;
  final String locations;
final String thumbnailName;

  CarDataModel(

        this.id,
        this.name,
        this.type,
        this.imageName,
        this.locations,
        this.thumbnailName
      );
 factory CarDataModel.fromJson(Map<String,dynamic> json)
  {return CarDataModel(
    json['id'],
   json['name'],
    json['type'],
    json['imageName'],
    json['locations'],
    json['thumbnailName'],);
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'imageName': imageName,
      'locations': locations,
      'thumbnailName': thumbnailName,
    };
  }
}