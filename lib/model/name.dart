class Name {
  final String title, first, last;

  Name(this.title, this.first, this.last);

  Name.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        first = json['first'],
        last = json['last'];
}
