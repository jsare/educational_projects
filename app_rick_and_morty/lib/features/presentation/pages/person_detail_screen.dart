import 'package:app_rick_and_morty/common/app_colors.dart';
import 'package:app_rick_and_morty/features/presentation/widgets/person_cache_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/person_entity.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;
  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 24,
            ),
            Text(
              person.name,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              child: PersonCacheImage(
                imageUrl: person.image,
                width: 260,
                height: 260,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  person.status,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (person.type.isNotEmpty) ...buildText('Type:', person.type),
            ...buildText('Gender:', person.gender),
            ...buildText(
                'Number of episodes:', person.episode.length.toString()),
            ...buildText('Species:', person.species),
            ...buildText('Last know location:', person.location.name),
            ...buildText('Last origin:', person.origin.name),
            ...buildText('Last created:', person.created.toString()),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(text, style: const TextStyle(color: AppColors.greyColor)),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(color: Colors.white)),
      const SizedBox(height: 12),
    ];
  }
}
