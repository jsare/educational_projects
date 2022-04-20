import 'package:app_rick_and_morty/common/app_colors.dart';
import 'package:app_rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:app_rick_and_morty/features/presentation/pages/person_detail_screen.dart';
import 'package:app_rick_and_morty/features/presentation/widgets/person_cache_image.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;
  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonDetailPage(person: person)));
      }),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            PersonCacheImage(
              imageUrl: person.image,
              width: 166,
              height: 166,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    person.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 8.0,
                        width: 8.0,
                        decoration: BoxDecoration(
                          color: person.status == 'Alive'
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          '${person.status} - ${person.species}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text(
                    'Last known location:',
                    style: TextStyle(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    person.location.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text(
                    'Origin:',
                    style: TextStyle(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    person.origin.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
