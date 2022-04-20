import 'package:app_rick_and_morty_freezed_and_bloc/ui/widgets/character_status.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/character.dart';

class CustomListTile extends StatelessWidget {
  final Results result;
  const CustomListTile({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        color: const Color.fromRGBO(86, 86, 86, 0.8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: result.image,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      result.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CharacterStatus(
                    liveState: result.status == 'Alive'
                        ? LiveStatus.alive
                        : result.status == 'Dead'
                            ? LiveStatus.dead
                            : LiveStatus.unknow,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Species:',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              result.species,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender:',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              result.gender,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return ListTile(
    //   title: Text(
    //     result.name,
    //     style: const TextStyle(color: Colors.white),
    //   ),
    // );
  }
}
