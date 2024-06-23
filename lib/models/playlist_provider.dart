import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tune_wave/models/song.dart';

class PlaylistProvider extends ChangeNotifier{
  /// playlist of Songs
   final List<Song> _playList= [

     Song(
       songName: "Hope Is Everything",
       artistName: "New Rockers",
       albumArtImagePath: 'assets/song_images/1.jpeg',
       audioPath: 'songs/vanish_hope.mp3'
     ),

     Song(
         songName: "Now or Never",
         artistName: "Phil Sounds",
         albumArtImagePath: 'assets/song_images/2.jpeg',
         audioPath: 'songs/bensound.mp3'
     ),

     Song(
         songName: "Calm is Better",
         artistName: "Calvy Atom",
         albumArtImagePath: 'assets/song_images/3.jpg',
         audioPath: 'songs/bird_music.mp3'
     ),
     Song(
         songName: "Confident is Everything",
         artistName: "Peru Nils",
         albumArtImagePath: 'assets/song_images/4.png',
         audioPath: 'songs/4.mp3'
     ),
     Song(
         songName: "New Era Soon",
         artistName: "Veronica R",
         albumArtImagePath: 'assets/song_images/5.png',
         audioPath: 'songs/5.mp3'
     )
   ];

 /// AUDIO PLAYER
final AudioPlayer _audioPlayer = AudioPlayer();

    /// DURATIONS
Duration _currentDuration = Duration.zero;
Duration _totalDuration = Duration.zero;

   ///  CONSTRUCTOR
PlaylistProvider()
{
  listenToDuration();
}

   ///  INITIALLY NOT PLAYING
      bool _isPlaying=false;



   ///  PLAY SONG
   void play() async{
     final String path =_playList[_currentSongIndex!].audioPath;
     await _audioPlayer.stop();
     await _audioPlayer.play(AssetSource(path));
     _isPlaying=true;
     notifyListeners();
   }
   ///  PAUSE SONG
    void pause() async{
     await _audioPlayer.pause();
     _isPlaying=false;
     notifyListeners();

    }
   ///  RESUME SONG
   void resume() async{
     await _audioPlayer.resume();
     _isPlaying=true;
     notifyListeners();
   }

   ///  STOP SONG
   void stop() async{
     await _audioPlayer.stop();
     _isPlaying=false;
     notifyListeners();
   }
   ///  PAUSE OR RESUME
   void pauseOrResume() async {
     if(_isPlaying) {
       pause();
     } else {
       resume();
     }
     notifyListeners();
   }
   ///  SEEK TO SPECIFIC IN THE CURRENT SONG
   void seek(Duration position) async
   {
     await _audioPlayer.seek(position);
     notifyListeners();
   }
   ///  PLAY NEXT SONG
   void playNext() async
   {
    if(_currentSongIndex!=null)
      {
        if(_currentSongIndex!< _playList.length -1){
          // goto  the next song if its not the last song
          currentSongIndex=_currentSongIndex!+1;
        }
        else {
          // loop back to first song if its last song
          currentSongIndex=0;
        }
      }
    notifyListeners();

   }

   ///  PLAY PREVIOUS SONG
   void playPrevious() async{
     // if its more than 2 seconds, start over the current song
    if(_currentDuration.inSeconds > 2)
      {
        seek(Duration.zero);
      }
    else //if its within first 2 seconds of the song , goto previous song
      {
        if(_currentSongIndex!>0){
          currentSongIndex=_currentSongIndex!-1;
        }
        else{ // if its first song , loop back to last song
          currentSongIndex=_playList.length-1;
        }
      }
     notifyListeners();
   }


   ///  LIST TO DURATION
   void listenToDuration(){
    // listen for total duration
     _audioPlayer.onDurationChanged.listen((newDuration){
       _totalDuration=newDuration;
       notifyListeners();
     });
     // listen for current duration

     _audioPlayer.onPositionChanged.listen((newPosition){
       _currentDuration=newPosition;
     //  print('NEW POSTIION : $newPosition');
       notifyListeners();
     });
     // listen for current duration
      _audioPlayer.onPlayerComplete.listen((event)
      {
      });

   }
   ///  DISPOSE AUDIO PLAYER

   @override
   void dispose() {
     // Release all sources and dispose the player.
     _audioPlayer.dispose();

     super.dispose();
   }



   /// Current Song Playing Index
   int? _currentSongIndex;
   List<Song> get playlist => _playList;
   bool get isPlaying =>_isPlaying;
   Duration get currentDuration =>_currentDuration;
   Duration get totalDuration => _totalDuration;


   /// GETTERS
   int?  get currentSongIndex =>_currentSongIndex;


   /// SETTTERS
   set currentSongIndex(int? newIndex){

     _currentSongIndex=newIndex;
    if(newIndex!=null)
      {
        play();
         // play the song at the new index
      }
     //update UI
     notifyListeners();

   }

}