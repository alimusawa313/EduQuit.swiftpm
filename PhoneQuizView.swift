import SwiftUI

import SwiftUI

import SwiftUI
import AVFoundation

struct PhoneQuizView: View {
    
    struct Question {
        var question: String
        var answers: [String]
        var correctAnswerIndex: Int
    }
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int?
    @State private var showAlert = false
    @State private var quizCompleted = false
    
    @State private var player: AVAudioPlayer?
    @State private var selectedSound: String = "correct_answer"
    
    
    @State private var navigateToHomeView = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                Image("phone_quiz")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Did You Know?")
                        .font(.system(size: 80))
                        .bold()
                        .foregroundStyle(.white)
                    
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                            VStack{
                                
                                Text(questions[currentQuestionIndex].question)
                                    .font(.largeTitle)
                                    .foregroundStyle(.white)
                                
                                ForEach(0..<questions[currentQuestionIndex].answers.count, id: \.self) { index in
                                    Button(action: {
                                        self.checkAnswer(index)
                                    }) {
                                        HStack{
                                            Spacer()
                                            Text(questions[currentQuestionIndex].answers[index])
                                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                                .foregroundStyle(.white)
                                                .padding()
                                                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 1)
                                            Spacer()
                                        }
                                        
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.teal)
                                        )
                                        .foregroundColor(.white)
                                    }
                                    .padding(.vertical, 5)
                                }
                                
                            }.frame(width: UIScreen.main.bounds.size.width / 2)
                            
                        }
                        Spacer()
                    }
                    Spacer()
                    
                    HStack{
                        Spacer()
                        ZStack{
                            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                    
                    
                }.padding(EdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 50))
                    .sheet(isPresented: $showAlert) {
                        if quizCompleted{
                            CustomQuizDoneDialog(isPresented: $showAlert){
                                self.showAlert = false
                                self.selectedAnswerIndex = nil
                                navigateToHomeView = true
                                
                            }.presentationBackground(.clear)
                        }else{
                            CustomAlertDialog(isPresented: $showAlert) {
                                self.showAlert = false
                                self.selectedAnswerIndex = nil
                                
                            }.presentationBackground(.clear)
                        }
                        
                    }
            }.onAppear{
                playSound()    
            }
                .onDisappear {
//                    StartButtonSound.stopSound()
                }
                .navigationDestination(isPresented: $navigateToHomeView) {
                HomeView()
            }
        }.accentColor(.white) 
        .navigationViewStyle(StackNavigationViewStyle())
                   
    }
    func questionsCat(){
        
    }
    func checkAnswer(_ selectedAnswerIndex: Int) {
        if self.selectedAnswerIndex == nil {
            self.selectedAnswerIndex = selectedAnswerIndex
            
            if selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex {
                // Correct answer, move to the next question if available
                let nextIndex = currentQuestionIndex + 1
                if nextIndex < questions.count {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            self.currentQuestionIndex = nextIndex
                            self.selectedAnswerIndex = nil
                            selectedSound = "correct_answer"
                            playSound()
                        }
                    }
                } else {
                    // Quiz completed, handle completion
                    quizCompleted = true
                    showAlert = true
                    selectedSound = "quiz_done"
                    playSound()
                    StartButtonSound.stopSound()
                }
            } else {
                // Incorrect answer, show alert
                showAlert = true
                selectedSound = "wrong_answer"
                playSound()
            }
        }
    }
    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "wav") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Failed to load the sound: \(error)")
        }
        player?.play()
    }
    
    let questions: [Question] = [
        Question(question: "What term is commonly used to describe the excessive use of smartphones, leading to negative effects on one's daily life?", answers: ["Phone obsession", "Device addiction", "Nomophobia", "Gadget dependence"], correctAnswerIndex: 2),
        
        Question(question: "Which neurotransmitter is associated with the reward system in the brain and is often implicated in addictive behaviors, including phone addiction?", answers: ["Dopamine", "Serotonin", "Endorphins", "Acetylcholine"], correctAnswerIndex: 0),
        
        Question(question: "What is the term for the fear of being without one's phone or being unable to use it, even for a short period?", answers: ["Technophobia", "Digital anxiety", "Phone separation anxiety", "Mobile apprehension"], correctAnswerIndex: 2),
        
        Question(question: "How does blue light emitted by phone screens contribute to sleep disturbances and potential addiction?", answers: ["It enhances sleep quality", "It has no impact on sleep", "It disrupts melatonin production and sleep patterns", "It induces relaxation"], correctAnswerIndex: 2),
        
        Question(question: "Which age group is particularly vulnerable to developing phone addiction?", answers: ["Children under 5", "Teenagers", "Young adults (20s-30s)", "Seniors (60s and above)"], correctAnswerIndex: 1),
        
        Question(question: "True or False: Smartphone addiction can lead to physical health issues such as 'text neck' and eye strain.", answers: ["True", "False"], correctAnswerIndex: 0),
        
        Question(question: "What is the term for the practice of using a smartphone while walking, often leading to accidents or collisions?", answers: ["Phone striding", "Text strolling", "Smartphone sauntering", "Distracted walking"], correctAnswerIndex: 3),
        
        Question(question: "Which of the following is a common sign of phone addiction?", answers: ["Regular breaks from screen time", "Anxiety when not using the phone", "Limited social media presence", "Infrequent text messaging"], correctAnswerIndex: 1),
        
        Question(question: "What is the phenomenon where the constant checking of notifications and messages becomes a compulsive behavior?", answers: ["Notification fixation", "Ping obsession", "App attraction", "Phantom vibration syndrome"], correctAnswerIndex: 3),
        
        Question(question: "Which psychological factor is often associated with the development of phone addiction?", answers: ["High self-esteem", "Strong willpower", "Low self-esteem and loneliness", "Introversion"], correctAnswerIndex: 2),
    ]
}

#Preview {
    PhoneQuizView()
}

