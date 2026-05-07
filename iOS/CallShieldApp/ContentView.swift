import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("CallShield")
                    .font(.largeTitle)
                    .bold()

                Text("Protection active contre les appels indésirables")
                    .multilineTextAlignment(.center)

                Spacer()
            }
            .padding()
            .navigationTitle("Accueil")
        }
    }
}
