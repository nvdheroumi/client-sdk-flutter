import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../exts.dart';
import '../providers/room_provider.dart';
import '../providers/participant_provider.dart';
import '../providers/audio_provider.dart';
import '../providers/voice_provider.dart';

class ControlsWidget extends ConsumerStatefulWidget {
  final Room room;
  final LocalParticipant participant;

  const ControlsWidget(
    this.room,
    this.participant, {
    super.key,
  });

  @override
  ConsumerState<ControlsWidget> createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends ConsumerState<ControlsWidget> {
  CameraPosition position = CameraPosition.front;

  @override
  void initState() {
    super.initState();
    widget.participant.addListener(_onChange);
  }

  @override
  void dispose() {
    widget.participant.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    setState(() {});
  }

  bool get _enableAudio => widget.participant.isMicrophoneEnabled();

  bool get _enableVideo => widget.participant.isCameraEnabled();

  bool get _enableScreenShare => widget.participant.isScreenShareEnabled();

  @override
  Widget build(BuildContext context) {
    // Watch providers for reactive UI updates
    final audioInputDevices = ref.watch(audioInputDevicesProvider);
    final audioOutputDevices = ref.watch(audioOutputDevicesProvider);
    final selectedAudioInput = ref.watch(selectedAudioInputProvider);
    final selectedAudioOutput = ref.watch(selectedAudioOutputProvider);
    final speakerphoneOn = ref.watch(speakerphoneOnProvider);
    final voiceChatSettings = ref.watch(voiceChatSettingsNotifierProvider);
    final pushToTalkState = ref.watch(pushToTalkNotifierProvider);
    final currentSpeakers = ref.watch(currentSpeakersProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        children: [
          // Voice Mode Toggle
          if (lkPlatformIs(PlatformType.android) || lkPlatformIs(PlatformType.iOS))
            PopupMenuButton<VoiceChatMode>(
              icon: Container(
                decoration: BoxDecoration(
                  color: voiceChatSettings.mode == VoiceChatMode.pushToTalk 
                      ? (pushToTalkState ? Colors.red : Colors.grey)
                      : (voiceChatSettings.mode == VoiceChatMode.voiceActivated ? Colors.green : Colors.blue),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.mic_none, color: Colors.white),
                ),
              ),
              onSelected: (mode) {
                ref.read(voiceChatSettingsNotifierProvider.notifier).updateMode(mode);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: VoiceChatMode.openMic,
                  child: Text('Open Mic'),
                ),
                const PopupMenuItem(
                  value: VoiceChatMode.pushToTalk,
                  child: Text('Push to Talk'),
                ),
                const PopupMenuItem(
                  value: VoiceChatMode.voiceActivated,
                  child: Text('Voice Activated'),
                ),
              ],
            ),

          // Push to Talk Button (only show in push-to-talk mode)
          if (voiceChatSettings.mode == VoiceChatMode.pushToTalk)
            GestureDetector(
              onTapDown: (_) {
                ref.read(pushToTalkNotifierProvider.notifier).startTalking();
              },
              onTapUp: (_) {
                ref.read(pushToTalkNotifierProvider.notifier).stopTalking();
              },
              onTapCancel: () {
                ref.read(pushToTalkNotifierProvider.notifier).stopTalking();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: pushToTalkState ? Colors.red : Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.push_pin, color: Colors.white),
                ),
              ),
            ),

          // Microphone Toggle
          IconButton(
            onPressed: () async {
              await ref.read(localParticipantControlsNotifierProvider.notifier).toggleMicrophone();
            },
            icon: Icon(
              _enableAudio ? Icons.mic : Icons.mic_off,
              color: _enableAudio ? Colors.white : Colors.red,
            ),
            style: IconButton.styleFrom(
              backgroundColor: _enableAudio ? Colors.green : Colors.red.withOpacity(0.8),
            ),
          ),

          // Video Toggle
          IconButton(
            onPressed: () async {
              await ref.read(localParticipantControlsNotifierProvider.notifier).toggleCamera();
            },
            icon: Icon(
              _enableVideo ? Icons.videocam : Icons.videocam_off,
              color: _enableVideo ? Colors.white : Colors.red,
            ),
            style: IconButton.styleFrom(
              backgroundColor: _enableVideo ? Colors.green : Colors.red.withOpacity(0.8),
            ),
          ),

          // Screen Share Toggle
          IconButton(
            onPressed: () async {
              await ref.read(localParticipantControlsNotifierProvider.notifier).toggleScreenShare();
            },
            icon: Icon(
              _enableScreenShare ? Icons.stop_screen_share : Icons.screen_share,
              color: _enableScreenShare ? Colors.red : Colors.white,
            ),
            style: IconButton.styleFrom(
              backgroundColor: _enableScreenShare ? Colors.red : Colors.grey,
            ),
          ),

          // Audio Input Device Selection
          if (audioInputDevices.isNotEmpty)
            PopupMenuButton<MediaDevice>(
              icon: const Icon(Icons.settings_input_component),
              onSelected: (device) {
                ref.read(audioDeviceNotifierProvider.notifier).selectAudioInput(device);
              },
              itemBuilder: (context) => audioInputDevices
                  .map((device) => PopupMenuItem(
                        value: device,
                        child: ListTile(
                          leading: Icon(
                            selectedAudioInput?.deviceId == device.deviceId
                                ? Icons.check_circle
                                : Icons.mic,
                          ),
                          title: Text(device.label),
                          dense: true,
                        ),
                      ))
                  .toList(),
            ),

          // Audio Output Device Selection
          if (audioOutputDevices.isNotEmpty)
            PopupMenuButton<MediaDevice>(
              icon: const Icon(Icons.volume_up),
              onSelected: (device) {
                ref.read(audioDeviceNotifierProvider.notifier).selectAudioOutput(device);
              },
              itemBuilder: (context) => audioOutputDevices
                  .map((device) => PopupMenuItem(
                        value: device,
                        child: ListTile(
                          leading: Icon(
                            selectedAudioOutput?.deviceId == device.deviceId
                                ? Icons.check_circle
                                : Icons.speaker,
                          ),
                          title: Text(device.label),
                          dense: true,
                        ),
                      ))
                  .toList(),
            ),

          // Speakerphone Toggle (Mobile only)
          if (lkPlatformIs(PlatformType.android) || lkPlatformIs(PlatformType.iOS))
            IconButton(
              onPressed: () {
                ref.read(audioDeviceNotifierProvider.notifier).setSpeakerphoneOn(!speakerphoneOn);
              },
              icon: Icon(
                speakerphoneOn ? Icons.volume_up : Icons.phone_in_talk,
                color: speakerphoneOn ? Colors.blue : Colors.white,
              ),
              style: IconButton.styleFrom(
                backgroundColor: speakerphoneOn ? Colors.blue.withOpacity(0.2) : Colors.grey,
              ),
            ),

          // Voice Settings
          PopupMenuButton<String>(
            icon: const Icon(Icons.tune),
            onSelected: (value) {
              switch (value) {
                case 'noise_suppression':
                  ref.read(voiceChatSettingsNotifierProvider.notifier).toggleNoiseSuppression();
                  break;
                case 'echo_cancellation':
                  ref.read(voiceChatSettingsNotifierProvider.notifier).toggleEchoCancellation();
                  break;
                case 'auto_gain':
                  ref.read(voiceChatSettingsNotifierProvider.notifier).toggleAutoGainControl();
                  break;
                case 'spatial_audio':
                  ref.read(voiceChatSettingsNotifierProvider.notifier).toggleSpatialAudio();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'noise_suppression',
                child: ListTile(
                  leading: Icon(
                    voiceChatSettings.enableNoiseSuppression
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  title: const Text('Noise Suppression'),
                  dense: true,
                ),
              ),
              PopupMenuItem(
                value: 'echo_cancellation',
                child: ListTile(
                  leading: Icon(
                    voiceChatSettings.enableEchoCancellation
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  title: const Text('Echo Cancellation'),
                  dense: true,
                ),
              ),
              PopupMenuItem(
                value: 'auto_gain',
                child: ListTile(
                  leading: Icon(
                    voiceChatSettings.enableAutoGainControl
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  title: const Text('Auto Gain Control'),
                  dense: true,
                ),
              ),
              PopupMenuItem(
                value: 'spatial_audio',
                child: ListTile(
                  leading: Icon(
                    voiceChatSettings.enableSpatialAudio
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  title: const Text('Spatial Audio'),
                  dense: true,
                ),
              ),
            ],
          ),

          // Voice Quality Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.signal_cellular_alt,
                  size: 16,
                  color: _getQualityColor(voiceChatSettings.quality),
                ),
                const SizedBox(width: 4),
                Text(
                  voiceChatSettings.quality.name.toUpperCase(),
                  style: TextStyle(
                    color: _getQualityColor(voiceChatSettings.quality),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Speaking Indicator
          if (currentSpeakers.contains(widget.participant.identity))
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.record_voice_over,
                color: Colors.white,
                size: 16,
              ),
            ),

          // Disconnect Button
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.call_end, color: Colors.white),
            style: IconButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Color _getQualityColor(VoiceQuality quality) {
    switch (quality) {
      case VoiceQuality.excellent:
        return Colors.green;
      case VoiceQuality.high:
        return Colors.lightGreen;
      case VoiceQuality.medium:
        return Colors.orange;
      case VoiceQuality.low:
        return Colors.red;
    }
  }
}
