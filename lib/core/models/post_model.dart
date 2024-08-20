
class PostModel {
    int? id;
    String? title;
    String? body;
    String? image;

    PostModel({this.id, this.title, this.body, this.image});

    PostModel.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        title = json["title"];
        body = json["body"];
        image = json["image"];
    }

    static List<PostModel> fromList(List list) {
        return list.map((map) => PostModel.fromJson(map)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["title"] = title;
        _data["body"] = body;
        _data["image"] = image;
        return _data;
    }
}