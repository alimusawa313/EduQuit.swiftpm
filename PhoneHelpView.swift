import SwiftUI

struct PhoneHelpView: View{
    @State private var cigAmount:Int = 0
    @State private var isAddict:String = ""
    var body: some View{
        ZStack{
            
            Color.green
            
            HStack{
                VStack(alignment:.leading){
                    Text("Are You Addicted?")
                        .font(.system(size: 80))
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text("Concern you or someone on your family is addicted to their phone?\nAnswer this simple question")
                        .font(.system(size: 34))
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                    HStack{
                        Spacer()
                        VStack{
                            Text("How many hours is your screen-on-time per day?")
                                .bold()
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.black)
                            
                            HStack{
                                
                                Button(action: {
                                    if cigAmount > 0{
                                        cigAmount -= 1
                                    }
                                }, label: {
                                    Image(systemName: "minus")
                                        .padding()
                                        .foregroundStyle(.white)
                                        .frame(width: 50, height: 50)
                                        .background(Circle().fill(Color.black))
                                    
                                })
                                Text("\(cigAmount)")
                                    .bold()
                                    .font(.largeTitle)
                                    .padding()
                                
                                Button(action: {
                                    cigAmount += 1
                                }, label: {
                                    Image(systemName: "plus")
                                        .padding()
                                        .foregroundStyle(.white)
                                        .frame(width: 50, height: 50)
                                        .background(Circle().fill(Color.black))
                                    
                                })
                                
                            }
                            
                            Button(action: {
                                if cigAmount < 5{
                                    isAddict = "You are not considered an addict"
                                }else{
                                    
                                    isAddict = "You are addicted to your phone"
                                }
                            }, label: {
                                Text("Check")
                                    .padding()
                                    .foregroundStyle(.brown)
                                    .bold()
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                            })
                            
                            Text(isAddict)
                                .bold()
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12).fill(.red))
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    HStack{
                        Spacer()
                        Text("Visit this site for help:")
                        Link(destination: URL(string: "https://www.helpguide.org/articles/addictions/smartphone-addiction.htm")!) {
                            Text("Visit HelpGuide")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                            .cornerRadius(10)}
                        
                        Spacer()
                    }
                    
                }.padding()
                
                Spacer()
            }
        }
    } 
}

#Preview{
    PhoneHelpView()
}

