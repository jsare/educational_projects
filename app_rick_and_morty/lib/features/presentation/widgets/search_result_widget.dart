import 'package:app_rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:app_rick_and_morty/features/presentation/pages/person_detail_screen.dart';
import 'package:app_rick_and_morty/features/presentation/widgets/person_cache_image.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;
  const SearchResult({Key? key, required this.personResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PersonDetailPage(person: personResult),
          ),
        );
      }),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PersonCacheImage(
                imageUrl: personResult.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.location.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
