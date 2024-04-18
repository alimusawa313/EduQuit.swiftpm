//
//  StartView.swift
//  EduQuit
//
//  Created by Ali Haidar on 23/02/24.
//

import SwiftUI

struct StartView: View {
    @State private var logoScale: CGFloat = 1.0
    @State private var isButtonPressed = false
    @State private var navigateToHomeView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                VStack {
                    Spacer()
                    SoundWaveBg(minHeight: 100, maxHeight: 200, width: 45)
                        .opacity(0.5)
                    Spacer()
                }
                
                Image("logo")
                    .scaleEffect(logoScale)
                    .animation(.easeInOut(duration: 0.5), value: logoScale)
                    .onTapGesture {
                        withAnimation {
                            logoScale = 1.2
                            isButtonPressed = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            navigateToHomeView = true
                            
                        }
                    }
                
                if !isButtonPressed {
                    VStack(spacing: 50) {
                        Spacer()
                        Button("Start") {
                            withAnimation {
                                logoScale = 800
                                isButtonPressed = true
                                StartButtonSound.playSound(selectedSound: "start_button_sound")
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                navigateToHomeView = true
                            } 
                        }
                        .buttonStyle(GrowingButton())
                        
                        HStack {
                            Spacer()
//                            MuteButton()
//                                .padding(EdgeInsets(top: 15, leading: 25, bottom: 25, trailing: 25))
                        }
                    }
                }
            }.navigationDestination(isPresented: $navigateToHomeView) {
                HomeView()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}


#Preview {
    StartView()
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.pink)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .font(Font.system(size: 55))
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            .bold()
    }
}
