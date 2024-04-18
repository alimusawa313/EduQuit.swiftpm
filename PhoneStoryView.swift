import SwiftUI

import SwiftUI
import AVFoundation

struct PhoneStoryView: View{
    
    @State private var player: AVAudioPlayer?
    @State private var currentSoundIndex = 0
    
    @State private var navigateToHomeView = false
    
    var body: some View{
        NavigationStack{
            ZStack{
                Image("phone_quiz")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    Text(story[currentSoundIndex])
                        .bold()
                        .font(.system(size: 69))
                        .padding(EdgeInsets(top: 25, leading: 50, bottom: 25, trailing: 50))
                        .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 1)
                    
                    HStack{
                        Spacer()
                        if currentSoundIndex > 0{
                            
                            Button(action: {
                                player?.stop()
                                currentSoundIndex -= 1
                                playSound(sound: sound[currentSoundIndex])
                            }) {
                                HStack{
                                    Image(systemName: "chevron.backward.circle.fill").foregroundStyle(.white)
                                    Text("Previous")
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(.white)
                                        .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 1)
                                }.padding().background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.orange)
                                )
                            }
                        }
                        
                        if currentSoundIndex < story.count-1{
                            Button(action: {
                                player?.stop()
                                currentSoundIndex += 1
                                playSound(sound: sound[currentSoundIndex])
                            }) {
                                HStack{
                                    Text("Next")
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(.white)
                                        .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 1)
                                    Image(systemName: "chevron.forward.circle.fill").foregroundStyle(.white)
                                }.padding().background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.orange)
                                )
                            }
                        }else{
                            Button(action: {
                                player?.stop()
                                navigateToHomeView = true
                            }) {
                                HStack{
                                    Text("Finish")
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .foregroundStyle(.white)
                                        .padding()
                                        .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 1)
                                    Image(systemName: "cflag.checkered.2.crossed").foregroundStyle(.white)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
            }.padding()
                .onAppear {
                    playSound(sound: sound[currentSoundIndex])
                }
                .navigationDestination(isPresented: $navigateToHomeView) {
                    HomeView()}
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    @State private var sound = ["p1","p2","p3","p4","p5","p6","p7","p8", "p9"]
    
    @State private var story = ["In the bustling city of Technoville, where the hum of technology echoed through the streets, lived a woman named Emily. Her days were consumed by the glow of her phone screen, and the virtual world held a tighter grip on her than she ever realized.",
                                
                                "Emily's smartphone was an extension of her hand, a constant companion that accompanied her every waking moment. From the moment she woke up to the minute she fell asleep, the world beyond the screen seemed to blur into insignificance. Her addiction to the digital realm intensified with each passing day, as notifications, messages, and social media updates beckoned her into a seemingly endless loop.",
                                
                                "The people in Emily's life began to notice the disconnect. Friends grew concerned as conversations dwindled into one-sided interactions dominated by the glow of her screen. Family dinners became silent gatherings, with Emily's attention firmly fixed on the virtual conversations playing out in her palm.",
                                
                                "One day, as Emily mindlessly scrolled through her phone during a work meeting, her boss pulled her aside. Concern etched on his face, he expressed worry about her performance and the impact of her addiction on her professional life. It was a wake-up call for Emily, a realization that her relationship with her phone was spiraling out of control.",
                                
                                "Determined to reclaim her life, Emily decided to embark on a digital detox. She started by turning off non-essential notifications, freeing herself from the constant barrage of pings. She deleted time-consuming apps and replaced them with productivity tools that encouraged a healthier balance between work and leisure.",
                                
                                "Breaking free from the chains of her phone addiction was no easy feat. The first few days were marked by restlessness and the compulsion to check her phone at every spare moment. However, Emily found solace in rediscovering forgotten hobbies and reconnecting with the tangible world around her.",
                                
                                "Her journey to recovery took an unexpected turn when she joined a local community group dedicated to promoting digital wellness. Emily discovered that she wasn't alone in her struggles, and the shared stories of others provided both comfort and inspiration. Together, they organized events that encouraged face-to-face interactions and fostered a sense of community.",
                                
                                "As weeks turned into months, Emily's life underwent a remarkable transformation. She developed stronger relationships with friends and family, and her newfound focus translated into professional success. The once-constant buzz of her phone became a background hum, no longer the center of her universe.",
                                
                                "Emily's story became an inspiration for those grappling with their own digital dependencies in Technoville. Her journey showcased the transformative power of self-awareness and the importance of finding a balance between the digital and physical aspects of life. In a city where screens dominated every corner, Emily emerged as a beacon of hope, proving that it was possible to break free from the shackles of a smartphone-centric existence and rediscover the richness of the world beyond the screen."]
    
    func playSound(sound: String) {
        guard let soundURL = Bundle.main.url(forResource: sound, withExtension: "mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Failed to load the sound: \(error)")
        }
        player?.play() 
    }
    
}




#Preview{
    PhoneStoryView()
}
