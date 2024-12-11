import SwiftUI
import CoreGraphics

struct HexagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        let points = [
            CGPoint(x: width * 0.5, y: 0),
            CGPoint(x: width, y: height * 0.25),
            CGPoint(x: width, y: height * 0.75),
            CGPoint(x: width * 0.5, y: height),
            CGPoint(x: 0, y: height * 0.75),
            CGPoint(x: 0, y: height * 0.25)
        ]
        path.addLines(points)
        path.closeSubpath()
        return path
    }
}
