class Association {
  Association ({
    required this.id,
    required this.adress,
    required this.name,


  });

  int id;
  String adress;
  String name;


  factory Association .fromJson(Map<String, dynamic> json) => Association (
    id: json["id"],
    adress: json["adress"],
   name: json["name"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "adress": adress,
    "name": name,

  };
}
