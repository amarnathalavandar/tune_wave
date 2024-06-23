import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tune_wave/features/player/song_page.dart';
import 'package:tune_wave/models/playlist_provider.dart';

import '../../models/song.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlayerMainState();
}

class _PlayerMainState extends State<Playlist> {
  // get the playlist provider
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    //get playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  //go to a song on given songIndex
  void goToSong(int songIndex) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('W A V E T U N E ')),
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;

          ///return list view UI
          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                final Song song = playlist[index];
               // print('AMAR');
                //print("song-${playlist.length}");
                return ListTile(
                  onTap: () => goToSong(index),
                  title: Text(
                    song.songName,
                  ),
                  subtitle: Text(song.artistName),
                  leading: Image.asset(song.albumArtImagePath),
                );
              });
        },
      ),
    );
  }
}
