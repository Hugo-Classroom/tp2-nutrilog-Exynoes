import SwiftUI
import LocalAuthentication

struct RootView: View {
    @State private var isAuthenticated = false
    
    var body: some View {
        VStack {
            if isAuthenticated {
                HomeView()
            } else {
                LoginView(onLogin: authenticate) 
                                   .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: isAuthenticated)
        .onAppear {
            authenticate() 
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authentification requise pour accéder à Nutrilog"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success,
                Error in
                DispatchQueue.main.async {
                    if success {
                        isAuthenticated = true
                    } else {
                        print("\(Error?.localizedDescription ?? "inconnue")")
                        isAuthenticated = false
                    }
                }
            }
        }
    }
}
