import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';

import '../exts.dart';
import '../utils.dart';
import '../widgets/controls.dart';
import '../widgets/participant.dart';
import '../widgets/participant_info.dart';
import '../providers/room_provider.dart';
import '../providers/participant_provider.dart';
import '../providers/audio_provider.dart';
import '../providers/voice_provider.dart';

class RoomPage extends ConsumerStatefulWidget {
  final Room room;
  final EventsListener<RoomEvent> listener;

  const RoomPage(
    this.room,
    this.listener, {
    super.key,
  });

  @override
  ConsumerState<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends ConsumerState<RoomPage> {
  bool get fastConnection => widget.room.engine.fastConnectOptions != null;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize room state in Riverpod
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeRoomState();
    });

    if (lkPlatformIs(PlatformType.android)) {
      Hardware.instance.setSpeakerphoneOn(true);
    }

    if (lkPlatformIsDesktop()) {
      onWindowShouldClose = () async {
        await ref.read(roomNotifierProvider.notifier).disconnect();
      };
    }
  }

  @override
  void dispose() {
    onWindowShouldClose = null;
    super.dispose();
  }

  void _initializeRoomState() {
    // Set up the room state with the existing room and listener
    final roomNotifier = ref.read(roomNotifierProvider.notifier);
    final currentState = ref.read(roomNotifierProvider);
    
    // Update the state with the existing room and listener
    final newState = currentState.copyWith(
      room: widget.room,
      listener: widget.listener,
      connectionState: RoomConnectionState.connected,
    );
    
    // Set up event listeners through the provider
    _setupProviderListeners();
    
    if (!fastConnection) {
      _askPublish();
    }
  }

  void _setupProviderListeners() {
    widget.listener
      ..on<RoomDisconnectedEvent>((event) async {
        if (event.reason != null) {
          print('Room disconnected: reason => ${event.reason}');
        }
        WidgetsBindingCompatible.instance?.addPostFrameCallback(
            (timeStamp) => Navigator.popUntil(context, (route) => route.isFirst));
      })
      ..on<RoomRecordingStatusChanged>((event) {
        context.showRecordingStatusChangedDialog(event.activeRecording);
      })
      ..on<RoomAttemptReconnectEvent>((event) {
        print(
            'Attempting to reconnect ${event.attempt}/${event.maxAttemptsRetry}, '
            '(${event.nextRetryDelaysInMs}ms delay until next attempt)');
      })
      ..on<LocalTrackSubscribedEvent>((event) {
        print('Local track subscribed: ${event.trackSid}');
      })
      ..on<TrackE2EEStateEvent>(_onE2EEStateEvent)
      ..on<ParticipantNameUpdatedEvent>((event) {
        print(
            'Participant name updated: ${event.participant.identity}, name => ${event.name}');
      })
      ..on<ParticipantMetadataUpdatedEvent>((event) {
        print(
            'Participant metadata updated: ${event.participant.identity}, metadata => ${event.metadata}');
      })
      ..on<RoomMetadataChangedEvent>((event) {
        print('Room metadata changed: ${event.metadata}');
      })
      ..on<DataReceivedEvent>((event) {
        String decoded = 'Failed to decode';
        try {
          decoded = utf8.decode(event.data);
        } catch (err) {
          print('Failed to decode: $err');
        }
        context.showDataReceivedDialog(decoded);
      })
      ..on<AudioPlaybackStatusChanged>((event) async {
        if (!widget.room.canPlaybackAudio) {
          print('Audio playback failed for iOS Safari ..........');
          bool? yesno = await context.showPlayAudioManuallyDialog();
          if (yesno == true) {
            await widget.room.startAudio();
          }
        }
      });
  }

  void _askPublish() async {
    final result = await context.showPublishDialog();
    if (result != true) return;
    
    final localParticipant = ref.read(localParticipantProvider);
    if (localParticipant == null) return;

    // Use Riverpod providers for enabling camera and microphone
    try {
      await ref.read(localParticipantControlsNotifierProvider.notifier).toggleCamera();
    } catch (error) {
      print('could not publish video: $error');
      await context.showErrorDialog(error);
    }
    
    try {
      await ref.read(localParticipantControlsNotifierProvider.notifier).toggleMicrophone();
    } catch (error) {
      print('could not publish audio: $error');
      await context.showErrorDialog(error);
    }
  }

  void _onE2EEStateEvent(TrackE2EEStateEvent e2eeState) {
    print('E2EE State: ${e2eeState.state}');
  }

  @override
  Widget build(BuildContext context) {
    // Watch providers for reactive UI updates
    final participantTracks = ref.watch(participantTracksProvider);
    final connectionState = ref.watch(connectionStateProvider);
    final isRecording = ref.watch(isRecordingProvider);
    final localParticipant = ref.watch(localParticipantProvider);
    final voiceChatSettings = ref.watch(voiceChatSettingsNotifierProvider);
    final currentSpeakers = ref.watch(currentSpeakersProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: participantTracks.isNotEmpty
                    ? ParticipantWidget.widgetFor(participantTracks.first, showStatsLayer: true)
                    : Container(),
              ),
              if (participantTracks.length >= 2)
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: math.max(0, participantTracks.length - 1),
                    itemBuilder: (BuildContext context, int index) => Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 10),
                      child: ParticipantWidget.widgetFor(
                        participantTracks[index + 1],
                        showStatsLayer: false,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          // Connection state indicator
          if (connectionState == RoomConnectionState.connecting ||
              connectionState == RoomConnectionState.reconnecting)
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.orange.withOpacity(0.8),
                child: Text(
                  connectionState == RoomConnectionState.connecting 
                      ? 'Connecting...' 
                      : 'Reconnecting...',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),

          // Recording indicator
          if (isRecording)
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red.withOpacity(0.8),
                child: const Text(
                  'Recording in progress',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          // Voice chat mode indicator
          Positioned(
            top: 150,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Mode: ${voiceChatSettings.mode.name}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),

          // Speaking indicators
          if (currentSpeakers.isNotEmpty)
            Positioned(
              top: 180,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Speaking:',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    ...currentSpeakers.take(3).map((identity) => Text(
                      identity,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    )),
                    if (currentSpeakers.length > 3)
                      Text(
                        '+${currentSpeakers.length - 3} more',
                        style: const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                  ],
                ),
              ),
            ),

          // Controls
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: localParticipant != null
                ? ControlsWidget(widget.room, localParticipant)
                : Container(),
          ),
        ],
      ),
    );
  }
}
