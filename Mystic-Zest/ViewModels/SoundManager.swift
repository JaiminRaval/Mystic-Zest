//
//  SoundManager.swift
//  Mystic-Zest
//
//  Created by Jaimin Raval on 17/04/25.
//

import Foundation
import AVFoundation
import Combine

//  A class that manages Sounds at app level
class SoundManager: ObservableObject {
    static let shared = SoundManager()
    
    private var audioEngine: AVAudioEngine?
    private var playerNode: AVAudioPlayerNode?
    private var mixerNode: AVAudioMixerNode?
    private var currentBuffer: AVAudioPCMBuffer?
    private var audioFile: AVAudioFile?
    
    @Published private(set) var isPlaying = false
    @Published private(set) var currentTrackName: String?
    @Published private(set) var isLoading = false
    
    private var remoteDataTask: URLSessionDataTask?
    private var cancellables = Set<AnyCancellable>()
    
    private let audioQueue = DispatchQueue(label: "com.app.audioQueue", qos: .userInitiated)
        
    // Configuration
    private var fadeInDuration: TimeInterval = 2.0
    private var fadeOutDuration: TimeInterval = 1.5
    private var volume: Float = 0.7
    
    // MARK: - Public Methods
        
    /// Play a track from the app's assets
    /// - Parameter name: The name of the audio file in the app bundle
    func playLocalTrack(named name: String, fileExtension: String = "mp3") {
        guard currentTrackName != name || !isPlaying else { return }
        
        isLoading = true
        currentTrackName = name
        
        audioQueue.async { [weak self] in
            guard let self = self else { return }
            
            // Clean up any existing playback
//                self.cleanupExistingPlayback()
            
            guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Error: Could not find audio file named \(name).\(fileExtension)")
                }
                return
            }
//
//                self.setupAndPlayAudio(from: url)
        }
    }
    
    // to play tracks from remote server
    func playRemoteTrack(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL string")
            return
        }
        
        isLoading = true
        
        // Cancel any existing download
        remoteDataTask?.cancel()
        
        // Create a temporary file to store the audio data
        let tempFileURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".mp3")
        
        // Use a data task to download the file
        remoteDataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                self?.isLoading = false
                print("Error downloading audio: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                try data.write(to: tempFileURL)
                self.audioQueue.async {
//                    self.cleanupExistingPlayback()
//                    self.setupAndPlayAudio(from: tempFileURL)
                    self.currentTrackName = url.lastPathComponent
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Error writing audio data: \(error.localizedDescription)")
                }
            }
        }
        
        remoteDataTask?.resume()
    }
    
    /// Pause the currently playing track with a fade-out effect
        func pausePlayback() {
            guard isPlaying else { return }

        }
        
        /// Resume playback of a paused track with a fade-in effect
        func resumePlayback() {
            guard !isPlaying, playerNode != nil else { return }
            

        }
        
        /// Stop playback completely and release resources
        func stopPlayback() {

        }
        
        /// Set the volume level (0.0 to 1.0)
        func setVolume(_ volume: Float) {
            self.volume = max(0, min(1, volume))
            mixerNode?.outputVolume = self.volume
        }
        
        // MARK: - Private Methods
    
}
