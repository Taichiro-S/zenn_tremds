import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:zenn_trends/pages/rss_feed/model/rss_feed_article.dart';
import 'package:zenn_trends/pages/rss_feed/service/format_published_date.dart';
import 'package:zenn_trends/pages/rss_feed/widget/bookmark_button_widget.dart';

class ArticleContainerWidget extends ConsumerWidget {
  const ArticleContainerWidget({
    super.key,
    required this.article,
    required this.index,
  });
  final RssFeedArticle article;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final publishedDate = formatPublishedDate(article.publishedDate, now);
    return StickyHeaderBuilder(
      builder: (context, stuckAmount) {
        // stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
        return Container(
          height: 50.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
              colors: [
                const Color.fromARGB(255, 107, 202, 255)
                    .withOpacity(0.6 + 0.4 * stuckAmount),
                const Color.fromARGB(255, 179, 152, 255)
                    .withOpacity(0.6 + 0.4 * stuckAmount),
              ],
              stops: const [
                0.0,
                1.0,
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Row(children: [
            Text(
              publishedDate,
              style: const TextStyle(color: Colors.white),
            ),
            BookmarkButtonWidget(article: article),
            // IconButton(
            //     onPressed: () async {},
            //     icon: const Icon(
            //       Icons.bookmark_border,
            //       color: Colors.grey,
            //       size: 20,
            //     ))
          ]),
        );
      },
      content: Card(
          elevation: 3,
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    text: TextSpan(children: [
                      TextSpan(
                          text: article.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ])),
              ]))),
    );
  }
}
