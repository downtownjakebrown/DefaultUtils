//
// See LICENSE file for this package’s licensing information.
//

import SwiftUI

extension View {
    
    /// Adds touch down and touch up response to the view.
    ///
    /// This view-modifying function adds a tap gesture recognizer to the view. Actions may be triggered on both touch down and touch up events.
    ///
    /// - Parameters:
    ///   - touchDown: The action to perform when a touch starts.
    ///   - touchUp: The action to perform when a touch ends.
    /// - Returns: The modified view.
    public func onTouchEvent(
        touchDown: @escaping () -> Void = {},
        touchUp: @escaping () -> Void = {}
    ) -> some View {
        modifier(TouchDownUpEventModifier(touchDown, touchUp))
    }
}

struct TouchDownUpEventModifier: ViewModifier {
    
    @GestureState private var isPressed = false
    
    private let touchDown: () -> Void
    private let touchUp: () -> Void
    
    init(
        _ touchDown: @escaping () -> Void = {},
        _ touchUp: @escaping () -> Void = {}
    ) {
        self.touchDown = touchDown
        self.touchUp = touchUp
    }
    
    func body(content: Content) -> some View {
        content
        .gesture(
            DragGesture(minimumDistance: 0)
            .updating($isPressed) { (value, gestureState, transaction) in
                gestureState = true
            }
        )
        .onChange(of: isPressed, perform: { pressed in
            if pressed {
                self.touchDown()
            } else {
                self.touchUp()
            }
        })
    }
    
}
