import SwiftUI

import SwiftUI

struct CustomQuizDoneDialog: View {
    @Binding var isPresented: Bool
    var onDismiss: () -> Void
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 100))
                .foregroundColor(.white)
                .padding(.bottom, 20)
            
            Text("Quiz Completed")
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
                Text("Back to Home")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(width: 500, height: 300)
        .background(Color.green)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.green, lineWidth: 2)
        )
        .shadow(radius: 10)
    }
}


//#Preview {
//    CustomQuizDoneDialog()
//}
