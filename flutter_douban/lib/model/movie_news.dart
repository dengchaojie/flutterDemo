

class MovieNews {

  String title;
  String cover;
  String summary;
  String link;

  MovieNews(this.title, this.cover, this.summary, this.link);

  MovieNews.fromJson(Map data) {
    title = data['title'];
    cover = data['cover'];
    summary = data['summary'];
    link = data['link'];
    print(title);
    print(cover);
    print(link);
    print(summary);
  }


}