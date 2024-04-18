import SwiftUI

import SwiftUI

struct DrugHelpView: View{
    @State private var cigAmount:Int = 0
    @State private var isAddict:String = ""
    var body: some View{
        ZStack{
            
            Color.yellow
            
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
                            Text("Did you do drugs daily?")
                                .bold()
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.black)
                            
                            HStack{
                                
                                Button(action: {
                                    
                                    isAddict = "You are not an addict"
                                }, label: {
                                    Text("No")
                                        .padding()
                                        .foregroundStyle(.blue)
                                        .bold()
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                                    
                                })
                                
                                Button(action: {
                                    isAddict = "You are an addict"
                                }, label: {
                                    Text("Yes")
                                        .padding()
                                        .foregroundStyle(.white)
                                        .bold()
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .background(RoundedRectangle(cornerRadius: 12).fill(.red))
                                    
                                })
                                
                            }
                            
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
                            .foregroundStyle(.black)
                        Link(destination: URL(string: "https://www.dea.gov/recovery-resources")!) {
                            Text("Visit DEA")
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
    DrugHelpView()
}

