//
// See LICENSE file for this package’s licensing information.
//

import Foundation
import CoreHaptics

/// A class to manage and play CoreHaptics.
public class HapticFactory {
    
    /// An initializer that returns nil if device does not support haptics.
    public init?() {
        // Check device compatibility
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Device does not support haptics.")
            return nil
        }
        // Create the haptic engine object
        do {
            hapticEngine = try CHHapticEngine()
        } catch let error {
            print("Haptic engine Creation Error: \(error).")
            return nil
        }
    }
    
    /// The type of haptic pattern to be played.
    public enum HapticType {
        case singlePulse
        case doublePulse
    }
    
    /// Plays the specified haptic pattern.
    /// - Parameter hapticType: The type of haptic pattern to be played.
    public func playHaptic(_ hapticType: HapticType) {
        DispatchQueue.global(qos: .userInitiated).async {
            switch hapticType {
                case .singlePulse: self.singlePulse()
                case .doublePulse: self.doublePulse()
            }
        }
    }
    
    // Local prop to play the haptics
    private let hapticEngine: CHHapticEngine
    
}

// MARK: - Haptic Types
extension HapticFactory {
    
    private func singlePulse() {
        
        // Holds the haptic events
        var hapticEvents = [CHHapticEvent]()
        
        // Build the events array
        hapticEvents.append(makeTransientHaptic(intensity: 0.5, sharpness: 0.2))
        
        // Play the pattern
        playHapticPattern(hapticEvents)
        
    }
    
    private func doublePulse() {
        
        // Holds the haptic events
        var hapticEvents = [CHHapticEvent]()
        
        // Build the events array
        hapticEvents.append(makeTransientHaptic(intensity: 0.5, sharpness: 0.2))
        hapticEvents.append(makeTransientHaptic(intensity: 0.5, sharpness: 0.5, delay: 0.11))
        
        // Play the pattern
        playHapticPattern(hapticEvents)
        
    }
    
}

// MARK: - Helpers
extension HapticFactory {
    
    private func makeTransientHaptic(intensity: Float, sharpness: Float, delay: TimeInterval? = 0) -> CHHapticEvent {
        
        // Create an event (static) parameter to represent the haptic's intensity.
        let intensityParameter = CHHapticEventParameter(
            parameterID: .hapticIntensity,
            value: intensity
        )
        
        // Create an event (static) parameter to represent the haptic's sharpness.
        let sharpnessParameter = CHHapticEventParameter(
            parameterID: .hapticSharpness,
            value: sharpness
        )
        
        // Create an event to represent the transient haptic pattern.
        return CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensityParameter, sharpnessParameter],
            relativeTime: delay!
        )
        
    }
    
    private func playHapticPattern(_ hapticEvents: [CHHapticEvent]) {
        
        // Haptics lifecyle
        do {
            
            // Start the haptic engine
            try hapticEngine.start()
            
            // Make pattern from the events
            let pattern = try CHHapticPattern(events: hapticEvents, parameters: [])
            
            // Create a player to play the haptic pattern.
            let player = try hapticEngine.makePlayer(with: pattern)
            
            // Start the player
            try player.start(atTime: CHHapticTimeImmediate)

            // Stop the haptic engine when players are done
            hapticEngine.notifyWhenPlayersFinished { _ in
                return .stopEngine
            }
            
        } catch {
            
            // Error catch
            print("Couldn't play transient haptic.")
            
        }
        
    }
    
}
