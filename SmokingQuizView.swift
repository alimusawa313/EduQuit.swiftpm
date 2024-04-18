import SwiftUI
import AVFoundation

struct SmokingQuizView: View {
    
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
                
                Image("smoking_quiz")
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
                }
                .navigationDestination(isPresented: $navigateToHomeView) {
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
        Question(question: "What is the addictive substance found in cigarettes that leads to smoking addiction?", answers: ["Nicotine", "Caffeine", "THC", "Alcohol"], correctAnswerIndex: 0),
        
        Question(question: "Approximately how many chemicals are present in cigarette smoke, many of which are known to be harmful to health?", answers: ["100", "500", "1,000", "7,000"], correctAnswerIndex: 3),
        
        Question(question: "What is the term used to describe the psychological dependence on smoking, often characterized by cravings and a perceived inability to quit?", answers: ["Nicotine dependence", "Tobacco reliance", "Smoking compulsion", "Addiction fixation"], correctAnswerIndex: 0),
        
        Question(question: "Which of the following health conditions is NOT associated with smoking?", answers: ["Lung cancer", "Cardiovascular disease", "Diabetes", "Chronic obstructive pulmonary disease (COPD)"], correctAnswerIndex: 2),
        
        Question(question: "What is the primary factor that makes quitting smoking challenging for many individuals?", answers: ["Lack of awareness", "Social pressure", "Withdrawal symptoms", "High cost of cigarettes"], correctAnswerIndex: 2),
        
        Question(question: "True or False: Nicotine replacement therapies, such as patches and gum, can help individuals quit smoking by reducing withdrawal symptoms.", answers: ["True", "False"], correctAnswerIndex: 0),
        
        Question(question: "Which age group is most susceptible to developing a smoking addiction?", answers: ["Teenagers", "Young adults (20s-30s)", "Middle-aged adults (40s-50s)", "Seniors (60s and above)"], correctAnswerIndex: 0),
        
        Question(question: "How does secondhand smoke exposure (passive smoking) affect non-smokers' health?", answers: ["It has no impact.", "It may increase the risk of respiratory infections and other health problems.", "It improves overall health.", "It only affects children."], correctAnswerIndex: 1),
        
        Question(question: "What role does the environment play in smoking addiction?", answers: ["It has no influence.", "Genetic factors are the sole determinants.", "Environmental factors, such as peer pressure and social norms, can contribute.", "Only personal willpower matters."], correctAnswerIndex: 2),
        
        Question(question: "Which government agency is often involved in implementing anti-smoking campaigns and regulations to curb smoking addiction?", answers: ["Environmental Protection Agency (EPA)", "Federal Aviation Administration (FAA)", "Food and Drug Administration (FDA)", "National Aeronautics and Space Administration (NASA)"], correctAnswerIndex: 2),
    ]
}

#Preview {
    SmokingQuizView()
}

