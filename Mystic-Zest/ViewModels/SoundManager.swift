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
    
    
}
