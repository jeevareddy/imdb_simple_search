import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FilmCard extends StatefulWidget {
  final Map data;
  FilmCard({Key key, this.data}) : super(key: key);

  @override
  _FilmCardState createState() => _FilmCardState();
}

class _FilmCardState extends State<FilmCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 145,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(blurRadius: 8, color: Colors.grey[300])
                  ]),
              child: Row(
                children: [
                  Container(
                    width: 125,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data['Title'].toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    shadows: [Shadow(blurRadius: 1)]),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              widget.data['genre'] != null
                                  ? Text(
                                      widget.data['genre']
                                          .toString()
                                          .split(',')[0],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    )
                                  : Container(),
                              SizedBox(
                                height: 8,
                              ),
                              Wrap(
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  widget.data['rating'] != null
                                      ? Text(
                                          widget.data['rating'].toString(),
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.blue[600],
                                              fontWeight: FontWeight.w700),
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RatingBar(
                                    onRatingUpdate: (value) {},
                                    initialRating:
                                        double.parse(widget.data['rating']) / 2,
                                    itemSize: 20,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    glow: true,
                                    glowRadius: 3,
                                    direction: Axis.horizontal,
                                    ratingWidget: RatingWidget(
                                        full: Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                        ),
                                        half: ShaderMask(
                                          blendMode: BlendMode.srcIn,
                                          shaderCallback: (bounds) =>
                                              SweepGradient(
                                                  center:
                                                      Alignment.bottomCenter,
                                                  startAngle: (269 * pi / 180),
                                                  endAngle: (270 * pi / 180),
                                                  stops: [
                                                0,
                                                0.5
                                              ],
                                                  colors: [
                                                Colors.orange,
                                                Colors.grey
                                              ]).createShader(bounds),
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        empty: Icon(
                                          Icons.star,
                                          color: Colors.grey,
                                        )),
                                    unratedColor: Colors.grey,
                                    glowColor: Colors.orange,
                                    maxRating: 5,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            widget.data['Poster'] == 'N/A'
                ? Icon(
                    Icons.movie,
                    size: 100,
                    color: Colors.blue,
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 15),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(blurRadius: 3, color: Colors.grey)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          widget.data['Poster'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
