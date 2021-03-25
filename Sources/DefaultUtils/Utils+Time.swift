//
// See LICENSE file for this package’s licensing information.
//

import Foundation

extension TimeInterval {

    /// Converts milliseconds to seconds.
    public mutating func millsToSecs() {
        self /= 1000
    }
    
    /// Converts seconds to milliseconds.
    public mutating func secsToMills() {
        self *= 1000
    }
    
    /// Converts milliseconds to seconds.
    /// - Returns: TimeInterval in seconds.
    public func millsFromSecs() -> TimeInterval {
        let secs = self / 1000
        return secs
    }
    
    /// Converts seconds to milliseconds.
    /// - Returns: TimeInterval in milliseconds.
    public func secsFromMills() -> TimeInterval {
        let mills = self * 1000
        return mills
    }
    
    /// Converts a time into a user-friendly format.
    /// - Returns: The time rounded up to the nearest integer and converted to a string.
    public func roundAndStringify() -> String {
        return String(Int(ceil(self)))
    }
    
}
