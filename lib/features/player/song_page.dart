import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tune_wave/features/home/home_screen.dart';
import 'package:tune_wave/features/home/widgets/neu_box.dart';
import 'package:tune_wave/models/playlist_provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});


  // conver duration to min:sec
  String formatTime(Duration duration){
    String twoDigitSeconds=duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime="${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
        builder: (context, value, child)
    {
      /// get playlist
      final playlist = value.playlist;
      /// get current song index
      final currentSong=playlist[value.currentSongIndex ?? 0];
      return Scaffold(
      appBar: AppBar(centerTitle: true,
          title: Text(currentSong.songName),
        leading:IconButton(icon: const Icon(Icons.arrow_back_ios_new_outlined,), onPressed: () {
          value.stop();

        Navigator.push(context,MaterialPageRoute(builder: (context)=>const HomeScreen()));},

        )
      ),
          backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              /// APP BAR
              children: [

                const SizedBox(
                  height: 24,
                ),// ROW
                /// ALBUM ARTWORK
                NeuBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                          Image.asset(currentSong.albumArtImagePath)),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                               currentSong.songName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                currentSong.artistName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                              ),
                            ],
                          ),
                          const Icon(Ionicons.heart, color: Colors.red),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                /// SONG DURATION PROGRESS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// START  TIME
                      Text(formatTime(value.currentDuration).toString()),

                      /// SHUFFLE ICON
                      Icon(
                        Ionicons.shuffle_outline,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),

                      ///REPEAT ICON
                      Icon(
                        Ionicons.repeat_outline,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),

                      ///END TIME
                      Text(formatTime(value.totalDuration).toString()),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 0)),
                  child: Slider(
                    min: 0,
                    max: value.totalDuration.inSeconds.toDouble(),
                    value:value.currentDuration.inSeconds.toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Theme.of(context).colorScheme.onTertiary,
                    onChanged: (double double) {
                    //during when user is sliding around
                      value.seek(Duration(seconds: double.toInt()));

                    },
                    onChangeEnd: (double double){
                    //sliding has finished, go to that position in song duration
                      value.seek(Duration(seconds: double.toInt()));
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                /// PLAYBACK CONTROLS
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: value.playPrevious,
                        child:  NeuBox(
                          child: Icon(Ionicons.play_skip_back,color: Theme.of(context).colorScheme.onTertiary,),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: value.pauseOrResume,
                        child: NeuBox(
                          child: Icon(value.isPlaying ?Ionicons.pause :Ionicons.play,color: Theme.of(context).colorScheme.onTertiary),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: value.playNext,
                        child:  NeuBox(
                          child: Icon(Ionicons.play_skip_forward,color: Theme.of(context).colorScheme.onTertiary),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ), // COLUMN
    );
    });
        }

}
