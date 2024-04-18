import SwiftUI

import SwiftUI
import AVFoundation

struct DrugQuizView: View {
    
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
                
                Image("drug_quiz")
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
                                                .foregroundStyle(.black)
                                                .padding()
                                                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 1)
                                            Spacer()
                                        }
                                        
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color(red: 0.9803921568627451, green: 0.7803921568627451, blue: 0.6941176470588235))
                                        )
                                        .foregroundColor(.white)
                                    }
                                    .padding(.vertical, 5)
                                }
                                
                            }.frame(width: UIScreen.main.bounds.size.width / 2)
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    Spacer()
                    
                    HStack{
                        ZStack{
                            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        Spacer()
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
                }.navigationDestination(isPresented: $navigateToHomeView) {
                    HomeView()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        
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
        Question(question: "What is the term used to describe the compulsive and harmful use of substances, leading to physical and psychological dependence?", answers: ["Substance abuse", "Drug addiction", "Substance misuse", "Chemical dependency"], correctAnswerIndex: 1),
        
        Question(question: "Which neurotransmitter is often associated with the reward system in the brain and is frequently influenced by drugs of abuse?", answers: ["Serotonin", "Dopamine", "Acetylcholine", "GABA"], correctAnswerIndex: 1),
        
        Question(question: "Which of the following is a common symptom of drug withdrawal?", answers: ["Increased energy", "Euphoria", "Fatigue and irritability", "Improved concentration"], correctAnswerIndex: 2),
        
        Question(question: "What is the term for the process of gradually reducing the dose of a drug to minimize withdrawal symptoms?", answers: ["Abstinence", "Detoxification", "Tapering", "Relapse"], correctAnswerIndex: 2),
        
        Question(question: "Which category of drugs includes substances like heroin, morphine, and prescription painkillers?", answers: ["Stimulants", "Hallucinogens", "Opioids", "Sedatives"], correctAnswerIndex: 2),
        
        Question(question: "True or False: Drug addiction is purely a result of weak willpower and lack of moral character.", answers: ["True", "False"], correctAnswerIndex: 1),
        
        Question(question: "What is the primary purpose of medication-assisted treatment (MAT) in addressing drug addiction?", answers: ["To induce a euphoric state", "To replace the addicted substance with a less harmful one", "To reduce cravings and withdrawal symptoms", "To promote recreational drug use"], correctAnswerIndex: 2),
        
        Question(question: "Which factor is not considered a risk factor for developing drug addiction?", answers: ["Genetic predisposition", "Socioeconomic status", "Age", "Blood type"], correctAnswerIndex: 3),
        
        Question(question: "What is the term for a return to drug use after a period of abstinence or control?", answers: ["Resistance", "Relapse", "Remission", "Regression"], correctAnswerIndex: 1),
        
        Question(question: "Which of the following is a behavioral therapy approach commonly used in the treatment of drug addiction?", answers: ["Electroconvulsive therapy (ECT)", "Aversion therapy", "Cognitive-behavioral therapy (CBT)", "Hormone replacement therapy (HRT)"], correctAnswerIndex: 2)
    ]
    
    
}

#Preview {
    DrugQuizView()
}

