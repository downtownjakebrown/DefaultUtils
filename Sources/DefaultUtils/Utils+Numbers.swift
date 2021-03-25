//
// See LICENSE file for this package’s licensing information.
//

import Foundation

extension Comparable {
    
    /// Given an upper and lower bound, returns a number constrained to within the range's bounds.
    /// - Parameter limits: The range in which the number is constrained.
    /// - Returns: The clamped number.
    public func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
    
}
