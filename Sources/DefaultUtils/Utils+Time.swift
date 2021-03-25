//
// See LICENSE file for this package’s licensing information.
//

import Foundation

extension TimeInterval {
    func millsToSecs() -> TimeInterval {
        let secs = self / 1000
        return secs
    }
    func secsToMills() -> TimeInterval {
        let mills = self * 1000
        return mills
    }
}
