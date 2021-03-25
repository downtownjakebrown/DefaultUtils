//
// See LICENSE file for this package’s licensing information.
//

import SwiftUI

extension View {
    
    /// Adds an inverse mask to the view.
    ///
    /// This view-modifying function adds an inverse mask (a clipping mask) to the view. The opacity of the masked portion is dependent upon the color of the mask. For a completely transparent masked portion, set the masking view's color to solid black.
    ///
    /// - Parameter mask: The view applied as a mask to self.
    /// - Returns: The modified view with portions masked.
    func inverseMask<Mask>(_ mask: Mask) -> some View where Mask: View {
        self.mask(mask
            .foregroundColor(.black)
            .background(Color.white)
            .compositingGroup()
            .luminanceToAlpha()
        )
    }
    
}
