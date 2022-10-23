//
//  BackgroundView.swift
//  SwiftUIDemo
//
//  Created by HaZe on 16/10/2022.
//

import SwiftUI

enum Direction {
    case up
    case down
}

struct Blob {
    var size: CGSize = .zero
    var middlePoint: CGPoint = .zero
    var direction: Direction = .down
    var colors: [Color] = []
    var speed: CGFloat = 100
}

struct BackgroundView: View {
    // Q: delete it and explain what happened
    @State var info = "BLOB View"
    
    var body: some View {
        ZStack {
            Color.white

            var blobs : [Blob] = [
                Blob(size: CGSize(width: 50, height: 50),
                         middlePoint: CGPoint(x: 20, y: 0),
                         direction: .up,
                         colors: [.pink,.red],
                         speed: 50),
                Blob(size: CGSize(width: 100, height: 100),
                         middlePoint: CGPoint(x: 60, y: 0),
                         direction: .up,
                         colors: [.cyan, .green,.blue],
                         speed: 90),
                Blob(size: CGSize(width: 160, height: 160),
                         middlePoint: CGPoint(x: 45, y: 0),
                         direction: .up,
                         colors: [.yellow, .indigo],
                         speed: 100)
            ]
            
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    // canvas size
                    let w = size.width
                    let h = size.height

                    // canvas background
                    context.fill( Path(CGRect(origin: .zero, size: size)),
                                  with: .color(Color(UIColor.systemBackground)))
                    context.addFilter(.blur(radius: 30))

                    // blobs
                    for idx in blobs.indices {
                        
                        let newCircle = nextPlaceOfBlob(canvasSize: CGSize(width: w, height: h),
                                                       blob: blobs[idx])
                        blobs[idx] = newCircle
                        let path = Circle().path(in: CGRect(x: (w / 100) * newCircle.middlePoint.x,
                                                            y: newCircle.middlePoint.y,
                                                            width: newCircle.size.width,
                                                            height: newCircle.size.height))

                        context.fill(
                                path,
                                with: .linearGradient(
                                    Gradient(colors: newCircle.colors),
                                    startPoint: .zero ,
                                    endPoint: CGPoint(x: size.width, y: size.height)
                                )
                            )
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }

    // calculate next position of current blob
    func nextPlaceOfBlob(canvasSize: CGSize, blob: Blob ) -> Blob {
        var newBlob = blob
        
        switch blob.direction {
        case .down:
            if newBlob.middlePoint.y  > (canvasSize.height - newBlob.size.height) {
                newBlob.direction = .up
            } else {
                newBlob.middlePoint.y += newBlob.size.height / newBlob.speed
            }
        case .up:
            if newBlob.middlePoint.y <= 0 {
                newBlob.direction = .down
            } else {
                newBlob.middlePoint.y -= newBlob.size.height / newBlob.speed
            }
        }
        return newBlob
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
            .preferredColorScheme(.light)
            .previewDisplayName("NN4M Blob Preview")
        BackgroundView()
            .preferredColorScheme(.dark)
            .previewDisplayName("NN4M Blob Dark Preview")
    }
}
