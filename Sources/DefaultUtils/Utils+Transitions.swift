//
// See LICENSE file for this package’s licensing information.
//

import SwiftUI

extension AnyTransition {
    
    /// Returns an asymmetric transition that moves the view towards the specified edges of the view on insertion and removal.
    /// - Parameters:
    ///   - insertion: The insertion direction.
    ///   - removal: The removal direction.
    /// - Returns: The asymmetric transition.
    public static func slide(
        insertion: Edge = .leading,
        removal: Edge = .trailing
    ) -> AnyTransition {
        return AnyTransition.asymmetric(
            insertion: createMoveTransition(insertion),
            removal: createMoveTransition(removal)
        )
    }

    private static func createMoveTransition(_ direction: Edge) -> AnyTransition {
        return AnyTransition.move(edge: direction)
    }
    
}
