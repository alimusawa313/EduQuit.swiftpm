import SwiftUI
import AVFoundation

struct SmokingStoryView: View{
    
    @State private var player: AVAudioPlayer?
    @State private var currentSoundIndex = 0
    
    @State private var navigateToHomeView = false
    
    var body: some View{
        NavigationStack{
            ZStack{
                Image("smoking_quiz")
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
                                        .fill(Color(red: 0.9803921568627451, green: 0.7803921568627451, blue: 0.6941176470588235))
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
                                        .fill(Color(red: 0.9803921568627451, green: 0.7803921568627451, blue: 0.6941176470588235))
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
    
    @State private var sound = ["s1","s2","s3","s4","s5","s6","s7","s8"]

    @State private var story = ["In a quaint town nestled between rolling hills, Jake, a man known for his affable nature, concealed a secret that cast a shadow over his life. Behind the charismatic façade lurked an addiction that gripped him relentlessly – an addiction to cigarettes.", "Jake's journey into the world of smoking began innocently in his teenage years, a rebellious act to fit in with the cool crowd. What started as an occasional puff morphed into an insatiable craving that consumed him over the years. The acrid scent of tobacco clung to him like a shadow, overshadowing the laughter and joy that once defined him.", "As the years passed, Jake's health deteriorated. His once-lively laughter was replaced by raspy coughs, and the twinkle in his eyes grew dim. Despite the concerned looks from friends and family, Jake remained defiant, convincing himself that he had control over his habit. In reality, the cigarettes controlled him.", "One day, a letter arrived that would change Jake's life. It was an invitation to his high school reunion – a chance to reconnect with old friends and revisit the carefree days of his youth. A spark of hope ignited within Jake. Perhaps this reunion could serve as a turning point, an opportunity to break free from the chains of his addiction.", "Determined to make a change, Jake embarked on a journey to rediscover himself and confront the demons that had held him captive for so long. As he reconnected with old friends at the reunion, they noticed the toll that smoking had taken on him. Concerned but supportive, they rallied around him, offering encouragement and understanding.", "Throughout the reunion, Jake found strength in the camaraderie of his friends. Inspired by their genuine care and concern, he made the life-altering decision to quit smoking for good. It wasn't an easy journey – withdrawal symptoms, cravings, and moments of weakness tested his resolve. Yet, with the unwavering support of his friends, Jake persevered.", "In the months that followed, Jake's transformation was nothing short of remarkable. His health improved, and his zest for life returned. He discovered new hobbies, rekindled old passions, and embraced a healthier lifestyle. The once-persistent cloud of smoke that enveloped him began to dissipate, revealing a brighter, clearer future.", "Jake's story became a source of inspiration for others in the small town, a testament to the power of friendship and the resilience of the human spirit. Though the road to recovery was challenging, Jake emerged from the shadows of addiction, proving that it's never too late to break free and start anew."]
    
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
    SmokingStoryView()
}
