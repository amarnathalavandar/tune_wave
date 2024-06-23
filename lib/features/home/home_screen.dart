import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tune_wave/features/home/widgets/row_heading.dart';
import 'package:tune_wave/features/home/widgets/search_container.dart';

import '../../models/playlist_provider.dart';
import '../../models/song.dart';
import '../player/song_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    //get playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  //go to a song on given songIndex
  void goToSong(int songIndex, BuildContext context) {
    // update current song index
    playlistProvider.currentSongIndex = songIndex;
    // Navigate to song page.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SongPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final twTextTheme = Theme.of(context).textTheme;
    final twColorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/tunewavelogo.png',
          scale: 2.8,
        ),
        toolbarHeight: 55,
      ),
      backgroundColor: twColorTheme.surface,
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        final List<Song> playlist = value.playlist;

        return Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(1, -.4),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: twColorTheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-1, -0.4),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: twColorTheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Column(
                  children: [
                    /// SEARCH CONTAINER
                    const TWSearchContainer(),
                    const SizedBox(height: 24),

                    /// RECENTLY PLAYED SONGS
                    const TWRowHeading(
                        leftHeading: 'RECENTLY PLAYED',
                        rightHeading: 'See All'),
                    const SizedBox(height: 20),

                    /// CARD FOR SONG PHOTO
                    Expanded(
                      flex: 10,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: value.playlist.length,
                        itemBuilder: (context, index) {
                          final Song song = playlist[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                  shadowColor: twColorTheme.onPrimary,
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          goToSong(index, context);
                                        },
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                          child: Image.asset(
                                            song.albumArtImagePath,
                                            fit: BoxFit.cover,
                                            scale: 3.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song.songName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    song.artistName,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// RECOMMENDATIONS AND SEE ALL
                    const TWRowHeading(
                        leftHeading: 'RECOMMENDATIONS',
                        rightHeading: 'See All'),
                    const SizedBox(height: 20),

                    /// LIST VIEW OF RECOMMENDATIONS
                    Expanded(
                      flex: 10,
                      child: ListView.separated(
                        itemCount: value.playlist.length,
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          color: Colors.grey.shade800,
                          endIndent: 50,
                          indent: 50,
                        ),
                        itemBuilder: (context, index) {
                          final Song song = playlist[index];
                          return ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            leading: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              child: Image.asset(
                                song.albumArtImagePath,
                                fit: BoxFit.cover,
                                scale: 5,
                              ),
                            ),
                            title: Text(
                              song.songName,
                              style: twTextTheme.bodyMedium,
                            ),
                            subtitle: Text(
                              song.artistName,
                              style: twTextTheme.bodySmall
                                  ?.copyWith(color: twColorTheme.secondary),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Ionicons.play),
                              onPressed: () {
                                goToSong(index, context);
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )),
          ],
        );
      }),
    );
  }
}
