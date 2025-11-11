import SwiftUI

struct LoginView: View {
    var onLogin: () -> Void 
    
    var body: some View {
        VStack {
            Image("nutrilogLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            
            Button(action: onLogin) {
                Label(NSLocalizedString("LogIn",comment: ""), systemImage: "faceid")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 170, height: 40)
                    .background(Color(red: 0.96, green: 0.62, blue: 0.04))
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.984, green: 0.976, blue: 0.953))
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView(onLogin: {})
}
