import SwiftUI

import SwiftUI

struct CustomAlertDialog: View {
    @Binding var isPresented: Bool
    var onDismiss: () -> Void
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 100))
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            Text("Wrong answer")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
            Button(action: {
                isPresented = false
                onDismiss()
            }) {
                Text("Try Again")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(width: 500, height: 300)
        .background(Color.red)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red, lineWidth: 2)
        )
        .shadow(radius: 10)
    }
}


//#Preview {
//    CustomAlertDialog()
//}
