import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:islami_app/my_theme/my_theme.dart';
import 'package:islami_app/home/tabs/radio_tab/repo/radio_reposetory.dart';

class RadioItemWidget extends StatefulWidget {
  final Radios radio;

  const RadioItemWidget({required this.radio});

  @override
  State<RadioItemWidget> createState() => _RadioItemWidgetState();
}

class _RadioItemWidgetState extends State<RadioItemWidget> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      try {
        await _player.setUrl(widget.radio.url!);
        await _player.play();
      } catch (e) {
        print("Error loading radio: $e");
      }
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _stopRadio() async {
    await _player.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _toggleVolume() async {
    _volume = _volume == 1.0 ? 0.0 : 1.0;
    await _player.setVolume(_volume);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 150,
          padding: EdgeInsets.symmetric(vertical: 28, horizontal: 16),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MYTheme.primaryColor,
          ),
          child: Image.asset("assets/images/Mosque-02.png"),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.radio.name ?? 'No Name',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: MYTheme.secondryColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _stopRadio,
                  icon: Icon(Icons.stop, color: MYTheme.secondryColor),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: _togglePlayPause,
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: MYTheme.secondryColor,
                  ),
                ),
                SizedBox(width: 16),
                IconButton(
                  onPressed: _toggleVolume,
                  icon: Icon(
                    _volume > 0.5 ? Icons.volume_up : Icons.volume_off,
                    color: MYTheme.secondryColor,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}