
import SwiftUI

struct ExplorerGradient: View {
    var body: some View {
		LinearGradient(gradient: Gradient(colors: [Color.gradientStart, Color.gradientEnd]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

/*

en faire le colorset : Color.complementaryColor
rgb(115, 170, 215)

*/

/* 

## Animated Gradient

	
@State private var animateGradient = false


LinearGradient(colors: [.purple, .yellow], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
    .ignoresSafeArea()
    .onAppear {
        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
            animateGradient.toggle()
        }
    }


## To gradient the typo

Text("Make gadient into this text")
 .foregroundStyle(

        LinearGradient(
            colors: [.red, .blue, .green, .yellow],
            startPoint: .leading,
            endPoint: .trailing
        )
    )
*/

/*

## Rotation foreever -> try on -15 to + 15 degree slowly duration high autoreverse true

struct LoadingContent: View {
      @State var degreesRotating = 0.0
    
      var body: some View {
        
      Image(systemName: "fanblades") // "star.fill"
          .font(.system(size: 80))
          .foregroundColor(.blue)
          .rotationEffect(.degrees(degreesRotating))
        
          .onAppear {
              withAnimation(.linear(duration: 1)
                  .speed(0.1).repeatForever(autoreverses: false)) {
                      degreesRotating = 360.0
                  }
          }
    }
}

## Make the logo app

https://developer.apple.com/tutorials/swiftui/drawing-paths-and-shapes

1. essayer de triangle + fleche
2. addarc pour arrondis ?

HWS : https://www.hackingwithswift.com/books/ios-swiftui/creating-custom-paths-with-swiftui
Triangle + bords arrondis avec : 

.stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin:, .round))

.strokeBorder ! => le contour reste interieur, ne sortira pas du frame 
 de la shape/view mais dois etre conforme a `InsettableShape` protocole

*/
