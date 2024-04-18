import SwiftUI
import AVFoundation

struct HomeView: View {
    @State private var player: AVAudioPlayer?
    
    @State public var navigateToDrugQuizView = false
    @State public var navigateToPhoneQuizView = false
    @State public var navigateToSmokingQuizView = false
    
    @State public var navigateToSmokingStoryView = false
    @State public var navigateToPhoneStoryView = false
    @State public var navigateToDrugStoryView = false
    
    @State public var navigateToSmokingHelpView = false
    @State public var navigateToPhoneHelpView = false
    @State public var navigateToDrugHelpView = false
    var body: some View {
        ZStack{
            Color.white
            SoundWaveBg(minHeight: 300, maxHeight: 400, width: 58)
                .opacity(0.5)
            
            VStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                
                LazyHStack(spacing:25){
                    CategorySelection(image: "smoke_main", title: "Smoking\nAddiction", onClickQuiz: {
                        navigateToSmokingQuizView=true
                    }, onClickGame: {}, onClickStory: {
                        navigateToSmokingStoryView = true
                    }, onClickHelp: {
                        navigateToSmokingHelpView = true
                    })
                    CategorySelection(image: "phone_main", title: "Phone\nAddiction", onClickQuiz: {
                        navigateToPhoneQuizView=true
                    }, onClickGame: {}, onClickStory: {
                        navigateToPhoneStoryView = true
                    }, onClickHelp: {
                        navigateToPhoneHelpView = true
                    })
                    CategorySelection(image: "drug_main", title: "Drug\nAddiction", onClickQuiz: {
                        navigateToDrugQuizView=true
                    }, onClickGame: {}, onClickStory: {
                        navigateToDrugStoryView = true
                    }, onClickHelp: {
                        navigateToDrugHelpView = true
                    })
                }
                
                
                Spacer()
                
                HStack {
                    Spacer()
                    MuteButton()
                        .padding(EdgeInsets(top: 15, leading: 25, bottom: 25, trailing: 25))
                }
                
            }.navigationDestination(isPresented: $navigateToDrugQuizView){DrugQuizView()}
                .navigationDestination(isPresented: $navigateToPhoneQuizView){PhoneQuizView()}
                .navigationDestination(isPresented: $navigateToSmokingQuizView){SmokingQuizView()}
            
                .navigationDestination(isPresented: $navigateToSmokingStoryView){SmokingStoryView()}
                .navigationDestination(isPresented: $navigateToPhoneStoryView){PhoneStoryView()}
                .navigationDestination(isPresented: $navigateToDrugStoryView){DrugStoryView()}
            
                .navigationDestination(isPresented: $navigateToSmokingHelpView){SmokeHelpView()}
                .navigationDestination(isPresented: $navigateToPhoneHelpView){PhoneHelpView()}
                .navigationDestination(isPresented: $navigateToDrugHelpView){DrugHelpView()}
        }.navigationBarBackButtonHidden()
    }
    
    struct CategorySelection: View{
        let image: String
        let title: String
        var onClickQuiz: () -> Void
        var onClickGame: () -> Void
        var onClickStory: () -> Void
        var onClickHelp: () -> Void
        var body: some View {
            VStack {
                
                ZStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.size.width / 6, height: UIScreen.main.bounds.size.height / 2)
                        .clipped()
                        .overlay(Color.black.opacity(0.2))
                    
                    VStack(){
                        
                        Text(title)
                            .foregroundColor(.white)
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .bold()
                            .padding()
                            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 1)
                        Spacer()
                     
                        BlurrButton(title: "Quiz", onClickQuiz: onClickQuiz, onClickGame: onClickGame, onClickStory: onClickStory, onClickHelp: onClickHelp)
//                        BlurrButton(title: "Game", onClickQuiz: onClickQuiz, onClickGame: onClickGame, onClickStory: onClickStory, onClickHelp: onClickHelp)
                        BlurrButton(title: "Story", onClickQuiz: onClickQuiz, onClickGame: onClickGame, onClickStory: onClickStory, onClickHelp: onClickHelp)
                        BlurrButton(title: "Help", onClickQuiz: onClickQuiz, onClickGame: onClickGame, onClickStory: onClickStory, onClickHelp: onClickHelp)
                        Spacer()
                    }
                }
            }
            .onAppear{
                StartButtonSound.playMusic(selectedSound: "main-song_")
                
            }
            .onDisappear{
                StartButtonSound.stopSound()
            }
            .frame(width: UIScreen.main.bounds.size.width / 6, height: UIScreen.main.bounds.size.height / 2)
            .cornerRadius(10)
        }
    }
    
    
    struct BlurrButton: View{
        let title: String
        var onClickQuiz: () -> Void
        var onClickGame: () -> Void
        var onClickStory: () -> Void
        var onClickHelp: () -> Void
        var body: some View{
            Button(action: {
                
                StartButtonSound.playSound(selectedSound: "button_sound")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if title == "Quiz" {
                        onClickQuiz()
                    } else if title == "Game" {
                        onClickGame()
                    } else if title == "Story" {
                        onClickStory()
                    } else {
                        onClickHelp()
                    }
                }
                
            }) {
                HStack{
                    Spacer()
                    Text(title)
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .padding() 
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.black)
                                    .opacity(0.3)
                                    .blur(radius: 10)
                                
                            }
                            
                        )
                    
                    Spacer()
                    
                }.clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
    
}

#Preview {
    HomeView()
}



