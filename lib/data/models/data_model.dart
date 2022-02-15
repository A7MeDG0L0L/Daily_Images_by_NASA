class DataModel{

late String? copyright;
late String date;
late String explanation;
late String? hdUrl;
late String mediaType;
late String serviceVersion;
late String title;
late String url;
late String? thumbs;

DataModel(
{
  required this.copyright,
  required this.date,
  required this.explanation,
  required this.title,
  required this.hdUrl,
  required this.mediaType,
  required this.serviceVersion,
  required this.url,
 required this.thumbs,
}
    );

DataModel.fromJson(Map<String,dynamic>json){

  copyright =  json['copyright'] == null ? null :json['copyright'];
  date = json['date'];
  url = json['url'];
  title = json['title'];
  mediaType = json['media_type'];
  serviceVersion = json['service_version'];
   thumbs = json['thumbnail_url'] == null ? null : json['thumbnail_url'];
  explanation = json['explanation'];
  hdUrl = json['hdurl']== null ? null :json['hdurl'];
  }
}