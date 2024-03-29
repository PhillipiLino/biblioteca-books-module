import 'package:biblioteca_components/biblioteca_components.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../domain/entities/book_entity.dart';

class HomeBookItem extends StatelessWidget {
  final BookEntity book;
  final Function onTap;
  const HomeBookItem(
    this.book, {
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (var i = 1; i <= 5; i++) {
      stars.add(Star(i <= book.stars));
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap as Function(),
        child: SizedBox(
          height: 150,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: 90,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BookImage(book.imagePath ?? ''),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.name,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      book.author,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 12),
                    Row(children: stars)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              CircularPercentIndicator(
                startAngle: 0,
                radius: 40.0,
                lineWidth: 12.0,
                percent: book.progress,
                center: Text(
                  book.percentage,
                  style: MainTextStyles.bodyMediumBold.copyWith(
                    color: Colors.white,
                  ),
                ),
                progressColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
              )
            ],
          ),
        ),
      ),
    );
  }
}
