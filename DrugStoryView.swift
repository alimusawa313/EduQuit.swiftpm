import SwiftUI

import SwiftUI

import SwiftUI
import AVFoundation

struct DrugStoryView: View{
    
    @State private var player: AVAudioPlayer?
    @State private var currentSoundIndex = 0
    
    @State private var navigateToHomeView = false
    
    var body: some View{
        NavigationStack{
            ZStack{
                Image("drug_quiz")
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
    
    @State private var sound = ["d1","d2","d3","d4","d5","d6","d7","d8", "d9", "d10"]
    
    @State private var story = ["In the gritty outskirts of Urbanville, a city teeming with both promise and peril, lived a man named Marcus. His days were a chaotic dance, fueled by the numbing embrace of drugs. What began as an escape from the harsh realities of life had transformed into an all-encompassing addiction that held him captive.",
                                
                                "Marcus, once a bright and ambitious individual, found himself entangled in a web of substance abuse. The allure of euphoria offered by the drugs became his refuge from the challenges and disappointments that life had thrown at him. As his dependency deepened, Marcus withdrew from the world, severing connections with friends and family who could see the toll the drugs were taking on him.",
                                
                                "One evening, as the neon lights of Urbanville flickered in the distance, Marcus had a chance encounter that would alter the course of his life. A stranger named Sam, a former addict who had managed to overcome the clutches of drugs, crossed paths with Marcus. Sam recognized the telltale signs of addiction in Marcus's vacant eyes and trembling hands.",
                                
                                "Rather than passing judgment, Sam extended a hand of empathy and understanding. He shared his own story of addiction, the struggles, and the arduous journey to recovery. Sam's words resonated with Marcus, igniting a spark of hope that had long been extinguished.",
                                
                                "Torn between the yearning for change and the relentless pull of addiction, Marcus hesitated. But Sam, undeterred, became a beacon of support. He introduced Marcus to a local rehabilitation program that focused not only on breaking the physical dependency but also on addressing the underlying issues that led to addiction.",
                                
                                "The journey to recovery was fraught with challenges. Withdrawal symptoms tested Marcus's resilience, and the shadows of his past haunted him. Yet, surrounded by a supportive community of fellow recovering addicts, Marcus found strength he never knew he possessed.",
                                
                                "As weeks turned into months, Marcus's transformation was palpable. He rekindled relationships with estranged family members, who cautiously embraced the changes they saw in him. Through counseling and therapy, Marcus confronted the demons that had driven him to drugs in the first place, gradually rebuilding the fragments of his shattered life.",
                                
                                "Sam remained a steadfast mentor, guiding Marcus through the highs and lows of recovery. Together, they founded a support group for recovering addicts in Urbanville, offering a lifeline to those navigating the tumultuous path to sobriety.",
                                
                                "Marcus's story echoed through the streets of Urbanville, serving as a testament to the power of redemption and resilience. His journey, though arduous, inspired others to confront their own struggles with addiction and seek the help they desperately needed.",
                                
                                "In a city where the allure of escape lurked around every corner, Marcus emerged as a symbol of hope, proving that even in the darkest depths of addiction, the human spirit could find the strength to rise, rebuild, and forge a new path toward a brighter tomorrow."]
    
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
    DrugStoryView()
}
